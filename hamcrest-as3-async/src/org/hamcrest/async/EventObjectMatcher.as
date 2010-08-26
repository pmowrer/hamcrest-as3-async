package org.hamcrest.async
{
    /**
     * 
     * @author Patrick Mowrer
     * 
     */	
    public interface EventObjectMatcher extends AsyncMatcher
    {
        function which(... rest):AsyncMatcher;    
    }
}