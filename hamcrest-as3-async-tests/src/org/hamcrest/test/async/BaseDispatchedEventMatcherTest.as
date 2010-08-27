package org.hamcrest.test.async
{
	import org.hamcrest.assertAsynchronouslyThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.hasProperty;
	import org.hamcrest.test.AbstractAsyncMatcherTestCase;

	public class BaseDispatchedEventMatcherTest extends AbstractAsyncMatcherTestCase
	{		
        private var eventDispatcher:FakeEventDispatcher;
        
        [Before]
        public function setUp():void
        {
            eventDispatcher = new FakeEventDispatcher();        
        }
        
		[Test(async)]
		public function canSupplyAdditionalRegularMatchersToMatchDispatchedEvent():void
		{		
			assertAsynchronouslyThat(eventDispatcher, 
				dispatchesExpectedEvent().which(hasProperty("data")), this);
			
			eventDispatcher.dispatchExpectedWithExpectedData();
		}
        
        [Test(async)]
        public function continuesToListenForEventIfDispatchedEventMatchesTypeButNotData():void
        {
            assertAsynchronouslyThat(eventDispatcher, 
                dispatchesExpectedEvent().which(hasProperty("data", equalTo(FakeEventDispatcher.EXPECTED))), this);

            eventDispatcher.dispatchExpectedWithUnexpectedData();
            eventDispatcher.dispatchExpectedWithExpectedData();
        }
	}
}

import org.hamcrest.async.AsyncMatcher;

internal function dispatchesExpectedEvent():BaseDispatchedEventMatcher
{
	return new ExpectedEventMatcher();
}

import flash.events.IEventDispatcher;

import org.hamcrest.Matcher;
import org.hamcrest.async.BaseDispatchedEventMatcher;
import org.hamcrest.Description;
import org.hamcrest.async.AsyncDescription;

internal class ExpectedEventMatcher extends BaseDispatchedEventMatcher
{	
	public function ExpectedEventMatcher()
	{
		super(FakeEventDispatcher.EXPECTED);
	}
	
	override protected function prepareTarget(target:Object):IEventDispatcher
	{
		return IEventDispatcher(target);
	}		
    
    override public function describeTo(description:Description):void
    {
        description
            .appendText("Event of type ")
            .appendValue(eventType)
            .appendText(" was dispatched");
    }
    
    override public function describeTimeoutTo(timeoutDescription:AsyncDescription):void
    {
        timeoutDescription
        .appendText("Event of type ")
            .appendValue(eventType)
            .appendText(" wasn't dispatched (timed out at ")
            .appendValue(timeout)
            .appendText(" ms)");         
    }
}

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.DataEvent;

internal class FakeEventDispatcher extends EventDispatcher
{
	public static const EXPECTED:String = "expected";
    public static const UNEXPECTED:String = "unexpected";

    private var dataEvent:DataEvent;
    
	public function dispatchExpectedWithExpectedData():void
	{
		dataEvent = new DataEvent(EXPECTED, EXPECTED);
		
		dispatchEvent(dataEvent);
	}
    
    public function dispatchExpectedWithUnexpectedData():void
    {
        dataEvent = new DataEvent(EXPECTED, UNEXPECTED); 
    
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