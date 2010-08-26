package org.hamcrest.test.async.signal
{
	import flash.events.Event;
	
	import org.hamcrest.assertAsynchronouslyThat;
	import org.hamcrest.async.BaseAsyncMatcher;
	import org.hamcrest.async.signal.dispatchesSignal;
	import org.hamcrest.async.signal.hasArguments;
	import org.hamcrest.test.AbstractAsyncMatcherTestCase;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class DispatchedSignalMatcherTest extends AbstractAsyncMatcherTestCase
	{		
		private var signalDispatcher:Signal;
		
		[Before]
		public function setUp():void
		{
			signalDispatcher = new Signal(String, int);
		}
		
		[Test(async)]
		public function passesWhenExpectedSignalWasDispatched():void
		{			
			assertAsynchronouslyThat(signalDispatcher, dispatchesSignal(), this);
			
			signalDispatcher.dispatch("Expected", 123);
		}

		[Test(async, expects="org.hamcrest.async.AssertionTimeoutError")]
		public function timesOutWhenExpectedSignalWasntDispatched():void
		{			
			assertAsynchronouslyThat(signalDispatcher, dispatchesSignal(), this);
		}
        
        [Test(async)]
        public function passesWhenExpectedSignalWithExpectedDataWasDispatched():void
        {
            assertAsynchronouslyThat(signalDispatcher, dispatchesSignal().which(hasArguments("Expected", 123)), this);
            
            signalDispatcher.dispatch("Expected", 123);
        }
        
        [Test(async, expects="org.hamcrest.AssertionError")]
        public function failsIfExpectedSignalWasDispatchedWithUnexpectedData():void
        {
            assertAsynchronouslyThat(signalDispatcher, dispatchesSignal().which(hasArguments("Expected", 123)), this);
            
            signalDispatcher.dispatch("Unexpected", 123);            
        }
		
		[Test]
		public function hasAReadableDescription():void
		{
			assertAsyncDescription("Signal was dispatched", dispatchesSignal());
		}
		
		[Test]
		public function hasAReadableTimeoutDescription():void
		{
			assertAsyncTimeoutDescription("Signal wasn't dispatched (timed out after <"
				+ BaseAsyncMatcher.DEFAULT_TIMEOUT + "> ms)", dispatchesSignal());
		}
	}
}
