package org.hamcrest.async.event
{
    import flash.events.IEventDispatcher;
    
    import org.hamcrest.Description;
    import org.hamcrest.async.AsyncDescription;
    import org.hamcrest.async.BaseDispatchedEventMatcher;
    
    /**
     * 
     * @author Patrick Mowrer
     * 
     */	
    public class DispatchedEventMatcher extends BaseDispatchedEventMatcher
    {
        public function DispatchedEventMatcher(type:String)
        {	
            super(type);
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
                .appendText(" wasn't dispatched (timed out after ")
                .appendValue(timeout)
                .appendText(" ms)");
        }
        
        override protected function prepareTarget(target:Object):IEventDispatcher
        {
            return IEventDispatcher(target);
        }
    }
}