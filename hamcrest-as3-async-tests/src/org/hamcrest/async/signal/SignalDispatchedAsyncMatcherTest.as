package org.hamcrest.async.signal
{
	import flash.events.Event;
	
	import org.hamcrest.AbstractAsyncMatcherTestCase;
	import org.hamcrest.assertAsynchronouslyThat;
	import org.hamcrest.async.BaseAsyncMatcher;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class SignalDispatchedAsyncMatcherTest extends AbstractAsyncMatcherTestCase
	{		
		private var signalDispatcher:Signal;
		
		[Before]
		public function setUp():void
		{
			signalDispatcher = new Signal();
		}
		
		[Test(async)]
		public function passesWhenSignalWasDispatched():void
		{			
			assertAsynchronouslyThat(signalDispatcher, dispatchesSignal(), this);
			
			signalDispatcher.dispatch();
		}

		[Test(async, expects="org.hamcrest.AssertionError")]
		public function timesOutWhenExpectedEventWasntDispatchedFromEventDispatcher():void
		{			
			assertAsynchronouslyThat(signalDispatcher, dispatchesSignal(), this);
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
