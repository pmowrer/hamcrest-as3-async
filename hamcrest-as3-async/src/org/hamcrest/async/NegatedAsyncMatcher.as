package org.hamcrest.async
{
    import org.hamcrest.Description;
    import org.hamcrest.Matcher;
    import org.hamcrest.object.isFalsey;
    
    /**
     * 
     * @author Patrick Mowrer
     * 
     */	
    public class NegatedAsyncMatcher implements AsyncMatcher
    {
        private var decorated:AsyncMatcher;
        
        public function NegatedAsyncMatcher(decorated:AsyncMatcher)
        {
            this.decorated = decorated;
        }
        
        public function callAsync(testCase:Object, target:Object, successHandler:Function, failureHandler:Function):Matcher
        {
            return decorated.callAsync(testCase, target, failureHandler, successHandler);
        }
        
        public function describeTimeoutTo(description:AsyncDescription):void
        {
            return decorated.describeTimeoutTo(description);
        }
        
        public function describeTo(description:Description):void
        {
            description.appendText("No ");
            
            return decorated.describeTo(description);
        }
    }
}