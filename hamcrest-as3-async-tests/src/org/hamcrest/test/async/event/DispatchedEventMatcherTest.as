package org.hamcrest.test.async.event
{
	import flash.events.Event;
	
	import org.hamcrest.assertAsynchronouslyThat;
	import org.hamcrest.async.BaseAsyncMatcher;
	import org.hamcrest.async.event.dispatchesEventOfType;
	import org.hamcrest.async.never;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.hasProperty;
	import org.hamcrest.test.AbstractAsyncMatcherTestCase;
	
	public class DispatchedEventMatcherTest extends AbstractAsyncMatcherTestCase
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

		[Test(async, expects="org.hamcrest.async.AssertionTimeoutError")]
		public function timesOutWhenExpectedEventWasntDispatchedFromEventDispatcher():void
		{			
			assertAsynchronouslyThat(eventDispatcher, dispatchesEventOfType(FakeEventDispatcher.EXPECTED), this);
			
			eventDispatcher.dispatchUnexpected();
		}
        
        [Test(async)]
        public function passesWhenEventWithExpectedPropertyWasDispatched():void
        {
            assertAsynchronouslyThat(eventDispatcher, 
                dispatchesEventOfType(FakeEventDispatcher.EXPECTED).which(hasProperty("data")), this);
            
            eventDispatcher.dispatchExpectedWithExpectedData();
        }
        
        [Test(async, expects="org.hamcrest.AssertionError")]
        public function failsWhenExpectedEventWithUnexpectedDataWasDispatched():void
        {
            assertAsynchronouslyThat(eventDispatcher, 
                dispatchesEventOfType(FakeEventDispatcher.EXPECTED)
                .which(hasProperty("data"), equalTo(FakeEventDispatcher.EXPECTED)), this);
            
            eventDispatcher.dispatchExpectedWithUnexpectedData();
        }

		[Test]
		public function hasAReadableDescription():void
		{
			assertAsyncDescription("Event of type \"" + FakeEventDispatcher.EXPECTED + "\" was dispatched", 
				dispatchesEventOfType(FakeEventDispatcher.EXPECTED));
		}
		
		[Test]
		public function hasAReadableTimeoutDescription():void
		{
			assertAsyncTimeoutDescription("Event of type \"" + FakeEventDispatcher.EXPECTED + 
				"\" wasn't dispatched (timed out after <" + BaseAsyncMatcher.DEFAULT_TIMEOUT + "> ms)", 
				dispatchesEventOfType(FakeEventDispatcher.EXPECTED));
		}
	}
}

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
	
	public function dispatchExpectedWithExpectedData():void
	{
		var dataEvent:DataEvent = new DataEvent(EXPECTED, EXPECTED);
		
		dispatchEvent(dataEvent);
	}
    
    public function dispatchExpectedWithUnexpectedData():void
    {
        var dataEvent:DataEvent = new DataEvent(EXPECTED, UNEXPECTED);
        
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