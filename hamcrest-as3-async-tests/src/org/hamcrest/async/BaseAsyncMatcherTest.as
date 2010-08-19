package org.hamcrest.async
{
	import org.hamcrest.assertAsynchronouslyThat;
	import org.hamcrest.object.hasProperty;

	public class BaseAsyncMatcherTest
	{		
		[Test(async)]
		public function canSupplyAdditionalRegularMatchersToMatchActualObject():void
		{
			var eventDispatcher:FakeEventDispatcher = new FakeEventDispatcher();
			
			assertAsynchronouslyThat(eventDispatcher, 
				dispatchesExpectedEvent().which(hasProperty("data")), this);
			
			eventDispatcher.dispatchExpectedWithData();
		}
	}
}

import org.hamcrest.async.AsyncMatcher;

internal function dispatchesExpectedEvent():AsyncMatcher
{
	return new FakeAsyncMatcher();
}

import flash.events.IEventDispatcher;

import org.hamcrest.Matcher;
import org.hamcrest.async.BaseAsyncMatcher;

internal class FakeAsyncMatcher extends BaseAsyncMatcher
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