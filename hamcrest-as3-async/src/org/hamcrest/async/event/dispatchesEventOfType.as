package org.hamcrest.async.event
{
    /**
     * 
     * @author Patrick Mowrer
     * 
     */	
    public function dispatchesEventOfType(value:String):EventDispatchedAsyncMatcher
    {
        return new EventDispatchedAsyncMatcher(value);
    }
}