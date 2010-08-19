package org.hamcrest.async.event
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import org.flexunit.async.Async;
	import org.hamcrest.Description;
	import org.hamcrest.Matcher;
	import org.hamcrest.async.AsyncDescription;
	import org.hamcrest.async.AsyncMatcher;
	import org.hamcrest.async.BaseAsyncMatcher;
	import org.hamcrest.core.AllOfMatcher;
	import org.hamcrest.object.isTruthy;
	
	public class EventDispatchedAsyncMatcher extends BaseAsyncMatcher
	{
		private var eventType:String;
		private var eventMatcher:Matcher;
		
		public function EventDispatchedAsyncMatcher(type:String)
		{
			super();			
			
			eventType = type;
			eventMatcher = isTruthy();
		}
		
		override public function describeTo(description:Description):void
		{
			description.appendText("Event of type '" + eventType + "' was dispatched");
		}
		
		override public function describeTimeoutTo(timeoutDescription:AsyncDescription):void
		{
			timeoutDescription.appendText(
				"Event of type '" + eventType + "' wasn't dispatched before timeout at 500 milliseconds");
		}
		
		override public function callAsync(testCase:Object, target:IEventDispatcher, resultHandler:Function, timeoutHandler:Function):Matcher
		{
			Async.handleEvent(testCase, target, eventType, resultHandler, timeout, null, timeoutHandler);
			
			return eventMatcher;
		}
		
		public function which(... rest):AsyncMatcher
		{
			var matchers:Array = rest;
			
			if (rest.length == 1 && rest[0] is Array)
			{
				matchers = rest[0];
			}
			
			eventMatcher = new AllOfMatcher(matchers);
			
			return this;
		}
	}
}