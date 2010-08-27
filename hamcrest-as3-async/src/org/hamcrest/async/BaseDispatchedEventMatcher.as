package org.hamcrest.async
{
    import flash.events.Event;
    
    import org.hamcrest.Description;
    import org.hamcrest.Matcher;
    import org.hamcrest.core.AllOfMatcher;
    import org.hamcrest.object.isTruthy;
    
    public class BaseDispatchedEventMatcher extends BaseAsyncMatcher implements EventObjectMatcher
    {
        protected var matcher:Matcher;
        
        public function BaseDispatchedEventMatcher(eventType:String)
        {
            super(eventType);
            
            matcher = isTruthy();
        }
        
        public function which(... rest):AsyncMatcher
        {
            var matchers:Array = rest;
            
            if (rest.length == 1 && rest[0] is Array)
            {
                matchers = rest[0];
            }
            
            matcher = new AllOfMatcher(matchers);
            
            return this;
        }
        
        override protected final function eventHandler(event:Event):void
        {
            if(matches(event))   
            {
                asyncHandler(event);
            }
        }
        
        protected function matches(event:Event):Boolean
        {
            return matcher.matches(event);
        }
    }
}