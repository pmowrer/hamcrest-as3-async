package org.hamcrest.async
{	
    import org.hamcrest.Matcher;
    
    /**
     * 
     * @author Patrick Mowrer
     * 
     */	
    public interface AsyncMatcher extends AsyncDescribing
    {
        function callAsync(testCase:Object, target:Object, successHandler:Function, failureHandler:Function):void;
    }
}