package org.hamcrest.async.event
{
	import flash.events.Event;
	
	import org.hamcrest.AbstractAsyncMatcherTestCase;
	import org.hamcrest.assertAsynchronouslyThat;
	import org.hamcrest.async.BaseAsyncMatcher;
	import org.hamcrest.object.hasProperty;
	
	public class EventDispatchedAsyncMatcherTest extends AbstractAsyncMatcherTestCase
	{		
		private var eventDispatcher:FakeEventDispatcher;
		
		[Before]
		public function setUp():void
		{
			eventDispatcher = new FakeEventDispatcher();
		}
		
		[Test(async)]
		public function passesWhenExpectedEventWasDispatchedFromEventDispatcher():void
		{			
			assertAsynchronouslyThat(eventDispatcher, dispatchesEventOfType(FakeEventDispatcher.EXPECTED), this);
			
			eventDispatcher.dispatchExpected();
		}

		[Test(async, expects="org.hamcrest.AssertionError")]
		public function timesOutWhenExpectedEventWasntDispatchedFromEventDispatcher():void
		{			
			assertAsynchronouslyThat(eventDispatcher, dispatchesEventOfType(FakeEventDispatcher.EXPECTED), this);
			
			eventDispatcher.dispatchUnexpected();
		}
		
		[Test]
		public function hasAReadableDescription():void
		{
			assertAsyncDescription("Event of type '" + FakeEventDispatcher.EXPECTED + "' was dispatched", 
				dispatchesEventOfType(FakeEventDispatcher.EXPECTED));
		}
		
		[Test]
		public function hasAReadableTimeoutDescription():void
		{
			assertAsyncTimeoutDescription("Event of type '" + FakeEventDispatcher.EXPECTED + 
				"' wasn't dispatched before timeout at " + BaseAsyncMatcher.DEFAULT_TIMEOUT + " milliseconds", 
				dispatchesEventOfType(FakeEventDispatcher.EXPECTED));
		}
		
		[Test(async)]
		public function canSupplyAdditionalRegularMatchersToMatchEventObject():void
		{
			assertAsynchronouslyThat(eventDispatcher, 
				dispatchesEventOfType(FakeEventDispatcher.EXPECTED).which(hasProperty("data")), this);
			
			eventDispatcher.dispatchExpectedWithData();
		}
	}
}

import flash.events.DataEvent;
import flash.events.Event;
import flash.events.EventDispatcher;

internal class FakeEventDispatcher extends EventDispatcher
{
	public static const EXPECTED:String = "expected";
	public static const UNEXPECTED:String = "unexpected";
	
	public function dispatchExpected():void
	{
		dispatchEvent(new Event(EXPECTED));
	}
	
	public function dispatchUnexpected():void
	{
		dispatchEvent(new Event(UNEXPECTED));
	}
	
	public function dispatchExpectedWithData():void
	{
		var dataEvent:DataEvent = new DataEvent(EXPECTED, "data");
		
		dispatchEvent(dataEvent);
	}
}

internal class DataEvent extends Event
{
	public var data:Object;
	
	public function DataEvent(type:String, data:Object)
	{
		super(type, false, false);
		
		this.data = data;
	}
}