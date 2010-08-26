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
	
	public class NegatedDispatchedEventMatcherTest extends AbstractAsyncMatcherTestCase
	{		
		private var eventDispatcher:FakeEventDispatcher;
		
		[Before]
		public function setUp():void
		{
			eventDispatcher = new FakeEventDispatcher();
		}
		
		[Test(async)]
		public function passesWhenExpectedEventWasntDispatchedBeforeTimeout():void
		{			
			assertAsynchronouslyThat(eventDispatcher, never(dispatchesEventOfType(FakeEventDispatcher.EXPECTED)), this);
		}
        
        [Test(async, expects="org.hamcrest.AssertionError")]
        public function failsWhenExpectedEventWasDispatchedBeforeTimeout():void
        {
            assertAsynchronouslyThat(eventDispatcher, never(dispatchesEventOfType(FakeEventDispatcher.EXPECTED)), this);
            
            eventDispatcher.dispatchExpected();
        }
        
        [Test(async)]
        public function passesWhenExpectedEventWasDispatchedWithUnexpectedDataBeforeTimeout():void
        {
            assertAsynchronouslyThat(eventDispatcher, 
                never(dispatchesEventOfType(FakeEventDispatcher.EXPECTED)
                    .which(hasProperty("data", equalTo(FakeEventDispatcher.EXPECTED)))), this);
            
            eventDispatcher.dispatchExpectedWithUnexpectedData();
        }
        
        [Test(async, expects="org.hamcrest.AssertionError")]
        public function failsWhenExpectedEventWasDispatchedWithExpectedDataBeforeTimeout():void
        {
            assertAsynchronouslyThat(eventDispatcher, 
                never(dispatchesEventOfType(FakeEventDispatcher.EXPECTED)
                    .which(hasProperty("data", equalTo(FakeEventDispatcher.EXPECTED)))), this);
            
            eventDispatcher.dispatchExpectedWithExpectedData();
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