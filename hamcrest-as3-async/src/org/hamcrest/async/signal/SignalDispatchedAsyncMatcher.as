package org.hamcrest.async.signal
{
    import flash.events.IEventDispatcher;
    
    import org.hamcrest.Description;
    import org.hamcrest.Matcher;
    import org.hamcrest.async.AsyncDescription;
    import org.hamcrest.async.BaseAsyncMatcher;
    
    import org.osflash.signals.Signal;
    import org.osflash.signals.utils.SignalAsync;
    import org.osflash.signals.utils.SignalAsyncEvent;
    
    /**
     * 
     * @author Patrick Mowrer
     * 
     */	
    public class SignalDispatchedAsyncMatcher extends BaseAsyncMatcher
    {	
        public function SignalDispatchedAsyncMatcher()
        {
            super(SignalAsyncEvent.CALLED);
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
        
        override protected function prepareTarget(target:Object):IEventDispatcher
        {
            return new SignalAsync(target as Signal);
        }
    }
}