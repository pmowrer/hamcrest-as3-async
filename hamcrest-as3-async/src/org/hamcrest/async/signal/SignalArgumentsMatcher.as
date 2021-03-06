package org.hamcrest.async.signal
{
    import org.hamcrest.Description;
    import org.hamcrest.Matcher;
    import org.hamcrest.TypeSafeDiagnosingMatcher;
    import org.osflash.signals.utils.SignalAsyncEvent;
    
    /**
     * 
     * @author Patrick Mowrer
     * 
     */	
    public class SignalArgumentsMatcher extends TypeSafeDiagnosingMatcher
    {
        private var argumentMatchers:Array;
        
        public function SignalArgumentsMatcher(argumentMatchers:Array)
        {
            super(SignalAsyncEvent);
            
            this.argumentMatchers = argumentMatchers;
        }
        
        override public function matchesSafely(event:Object, mismatchDescription:Description):Boolean
        {
            var matches:Boolean = true;
            var eventArguments:Array = (event as SignalAsyncEvent).args;
            
            if (eventArguments.length != argumentMatchers.length)
            {   
                matches = false;
            }
            else
            {
                argumentMatchers.forEach(matchesArgument);
                
                function matchesArgument(matcher:Matcher, i:int, a:Array):void
                {
                    if(!matcher.matches(eventArguments[i]))
                    {
                        matches = false;
                    }
                }
            }
            
            if(!matches)
            {
                mismatchDescription.appendText(" was ")
                    .appendList(descriptionStart(), descriptionSeparator(), descriptionEnd(), eventArguments);
            }
            
            return matches;
        }
        
        override public function describeTo(description:Description):void
        {
            description
            .appendText(" with arguments ")
                .appendList(descriptionStart(), descriptionSeparator(), descriptionEnd(), argumentMatchers);
        }
        
        /**
         * @private
         */
        protected function descriptionStart():String
        {
            return "[";
        }
        
        /**
         * @private
         */
        protected function descriptionSeparator():String
        {
            return ", ";
        }
        
        /**
         * @private
         */
        protected function descriptionEnd():String
        {
            return "]";
        }
    }
}