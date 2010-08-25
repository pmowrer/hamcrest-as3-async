package org.hamcrest
{	
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    
    import org.hamcrest.async.AsyncDescription;
    import org.hamcrest.async.AsyncMatcher;
    import org.hamcrest.async.AsyncStringDescription;
    
    /**
     * Used internally by <code>assertAsynchronouslyThat</code>.
     *
     * @param reason 		Custom description of failure traced if the assertion fails.
     * @param target 		Object which will exhibit asynchronous behavior.
     * @param asyncMatcher 	Matcher to match <code>target</code> with.
     * @param testCase 		The assoicated test case.
     * 
     * @author Patrick Mowrer
     * 
     */	
    internal function assertAsynchronouslyThatMatcher(reason:String, target:Object, 
                                                      asyncMatcher:AsyncMatcher, testCase:Object):void
    {		
        var matcher:Matcher = asyncMatcher.callAsync(testCase, target, resultHandler, timeoutHandler);
        
        var errorDescription:AsyncDescription = new AsyncStringDescription();
        var matcherDescription:AsyncDescription = new AsyncStringDescription();
        var mismatchDescription:AsyncDescription = new AsyncStringDescription();
        
        function resultHandler(event:Event, data:Object = null):void 
        {			
            if(!matcher.matches(event))
            {	
                if (reason && reason.length > 0)
                {
                    errorDescription
                    .appendText(reason)
                        .appendText("\n");
                }
                
                errorDescription
                .appendText("Expected: ")
                    .appendDescriptionOf(matcher)
                    .appendText("\n     but: ")
                    .appendMismatchOf(matcher, event);
                
                matcherDescription.appendDescriptionOf(matcher);
                
                mismatchDescription.appendMismatchOf(matcher, event);
                
                throw new AssertionError(
                    errorDescription.toString(), 
                    null, 
                    matcherDescription.toString(), 
                    mismatchDescription.toString(), 
                    event);
            }
        }
        
        function timeoutHandler(data:Object = null):void 
        {	
            if (reason && reason.length > 0)
            {
                errorDescription
                .appendText(reason)
                    .appendText("\n");
            }
            
            errorDescription
            .appendText("Expected: ")
                .appendDescriptionOf(asyncMatcher)
                .appendText("\n     but: ");
            
            (errorDescription as AsyncDescription).appendTimeoutDescriptionOf(asyncMatcher);
            
            throw new AssertionError(
                errorDescription.toString());			
        }
    }
}
