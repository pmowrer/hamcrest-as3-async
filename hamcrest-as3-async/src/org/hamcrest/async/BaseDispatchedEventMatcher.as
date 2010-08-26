package org.hamcrest.async
{
    import org.hamcrest.Description;
    import org.hamcrest.Matcher;
    import org.hamcrest.core.AllOfMatcher;
    import org.hamcrest.object.isTruthy;
    
    public class BaseDispatchedEventMatcher extends BaseAsyncMatcher implements EventObjectMatcher
    {
        private var whichIsSet:Boolean;
        
        public function BaseDispatchedEventMatcher(eventType:String)
        {
            super(eventType, isTruthy());
            
            whichIsSet = false;
        }
        
        public function which(... rest):AsyncMatcher
        {
            var matchers:Array = rest;
            
            if (rest.length == 1 && rest[0] is Array)
            {
                matchers = rest[0];
            }
            
            eventObjectMatcher = new AllOfMatcher(matchers);
            
            whichIsSet = true;
            
            return this;
        }
        
        override public function describeTo(description:Description):void
        {
            super.describeTo(description);
            
            if(whichIsSet)
            {
                description.appendText(" which ");
            }
        }
    }
}