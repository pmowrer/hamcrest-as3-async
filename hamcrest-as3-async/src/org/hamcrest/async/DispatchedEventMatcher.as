package org.hamcrest.async
{
    /**
     * 
     * @author Patrick Mowrer
     * 
     */	
    public interface DispatchedEventMatcher extends AsyncMatcher
    {
        function which(... rest):AsyncMatcher;    
    }
}