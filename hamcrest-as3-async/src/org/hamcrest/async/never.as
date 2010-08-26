package org.hamcrest.async
{
    /**
     * 
     * @author Patrick Mowrer
     * 
     */	
    public function never(matcher:AsyncMatcher):AsyncMatcher
    {
        return new NegatedAsyncMatcher(matcher);
    }
}