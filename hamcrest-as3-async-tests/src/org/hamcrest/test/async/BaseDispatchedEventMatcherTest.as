package org.hamcrest.test.async
{
	import org.hamcrest.assertAsynchronouslyThat;
	import org.hamcrest.object.hasProperty;
	import org.hamcrest.test.AbstractAsyncMatcherTestCase;

	public class BaseDispatchedEventMatcherTest extends AbstractAsyncMatcherTestCase
	{		
		[Test(async)]
		public function canSupplyAdditionalRegularMatchersToMatchDispatchedEvent():void
		{
			var eventDispatcher:FakeEventDispatcher = new FakeEventDispatcher();
			
			assertAsynchronouslyThat(eventDispatcher, 
				dispatchesExpectedEvent().which(hasProperty("data")), this);
			
			eventDispatcher.dispatchExpectedWithData();
		}
	}
}

import org.hamcrest.async.AsyncMatcher;

internal function dispatchesExpectedEvent():BaseDispatchedEventMatcher
{
	return new FakeAsyncMatcher();
}

import flash.events.IEventDispatcher;

import org.hamcrest.Matcher;
import org.hamcrest.async.BaseDispatchedEventMatcher;
import org.hamcrest.Description;

internal class FakeAsyncMatcher extends BaseDispatchedEventMatcher
{	
	public function FakeAsyncMatcher()
	{
		super(FakeEventDispatcher.EXPECTED);
	}
	
	override protected function prepareTarget(target:Object):IEventDispatcher
	{
		return IEventDispatcher(target);
	}		
}

import flash.events.Event;
import flash.events.EventDispatcher;

internal class FakeEventDispatcher extends EventDispatcher
{
	public static const EXPECTED:String = "expected";

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