package org.hamcrest.async
{
    import org.hamcrest.Description;
    import org.hamcrest.Matcher;
    
    public class InvertedAsyncMatcher implements AsyncMatcher
    {
        private var decorated:AsyncMatcher;
        
        public function InvertedAsyncMatcher(decorated:AsyncMatcher)
        {
            this.decorated = decorated;
        }
        
        public function callAsync(testCase:Object, target:Object, resultHandler:Function, timeoutHandler:Function):Matcher
        {
            return decorated.callAsync(testCase, target, timeoutHandler, resultHandler);
        }
        
        public function describeTimeoutTo(description:AsyncDescription):void
        {
            return decorated.describeTo(description);
        }
        
        public function describeTo(description:Description):void
        {
            description.appendText("No ");
            
            return decorated.describeTo(description);
        }
    }
}