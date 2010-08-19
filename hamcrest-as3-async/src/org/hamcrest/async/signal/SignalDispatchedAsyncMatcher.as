package org.hamcrest.async.signal
{
	import flash.events.IEventDispatcher;
	
	import org.flexunit.async.Async;
	import org.hamcrest.Description;
	import org.hamcrest.Matcher;
	import org.hamcrest.async.AsyncDescription;
	import org.hamcrest.async.BaseAsyncMatcher;
	import org.hamcrest.object.isTruthy;
	import org.osflash.signals.Signal;
	import org.osflash.signals.utils.SignalAsync;
	import org.osflash.signals.utils.SignalAsyncEvent;

	public class SignalDispatchedAsyncMatcher extends BaseAsyncMatcher
	{	
		public function SignalDispatchedAsyncMatcher()
		{
		}
		
		override public function describeTo(description:Description):void
		{
			description.appendText("Signal was dispatched");
		}
		
		override public function describeTimeoutTo(timeoutDescription:AsyncDescription):void
		{
			timeoutDescription
				.appendText("Signal wasn't dispatched (timed out after ")
				.appendValue(timeout)
				.appendText(" ms)");
		}
	
		override public function callAsync(testCase:Object, target:Object, resultHandler:Function, timeoutHandler:Function):Matcher
		{
			handleEvent(testCase, new SignalAsync(Signal(target)), SignalAsyncEvent.CALLED, resultHandler, timeoutHandler);
			
			return isTruthy();
		}
	}
}