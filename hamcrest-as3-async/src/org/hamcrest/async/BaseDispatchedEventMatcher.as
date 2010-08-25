package org.hamcrest.async
{
    import org.hamcrest.Description;
    import org.hamcrest.Matcher;
    import org.hamcrest.core.AllOfMatcher;
    
    public class BaseDispatchedEventMatcher extends BaseAsyncMatcher implements DispatchedEventMatcher
    {
        public function BaseDispatchedEventMatcher(eventType:String)
        {
            super(eventType);
        }
        
        public function which(... rest):AsyncMatcher
        {
            var matchers:Array = rest;
            
            if (rest.length == 1 && rest[0] is Array)
            {
                matchers = rest[0];
            }
            
            actualMatcher = new AllOfMatcher(matchers);
            
            return this;
        }
    }
}