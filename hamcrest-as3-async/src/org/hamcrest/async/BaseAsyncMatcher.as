package org.hamcrest.async
{
	import flash.errors.IllegalOperationError;
	import flash.events.IEventDispatcher;
	
	import org.hamcrest.Description;
	import org.hamcrest.Matcher;
	
	public class BaseAsyncMatcher implements AsyncMatcher
	{	
		public static const DEFAULT_TIMEOUT:int = 500;
		
		protected var timeout:int;
		
		public function BaseAsyncMatcher()
		{
			timeout = DEFAULT_TIMEOUT;
		}
		
		public function describeTo(description:Description):void
		{
			throw new IllegalOperationError("BaseAsyncMatcher#description must be overriden by sub-class.");			
		}
				
		public function describeTimeoutTo(timeoutDescription:AsyncDescription):void
		{
			throw new IllegalOperationError("BaseAsyncMatcher#timeoutDescription must be overriden by sub-class.");
		}

		public function callAsync(testCase:Object, target:IEventDispatcher, resultHandler:Function, timeoutHandler:Function):Matcher
		{
			throw new IllegalOperationError("BaseAsyncMatcher#callAsync must be overriden by sub-class.");
		}		
		
		public function beforeTimeoutOf(value:int):AsyncMatcher
		{
			timeout = value;
			
			return this;
		}
	}
}