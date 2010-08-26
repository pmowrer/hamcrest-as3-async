package org.hamcrest.async.event
{
    /**
     * 
     * @author Patrick Mowrer
     * 
     */	
    public function dispatchesEventOfType(value:String):DispatchedEventMatcher
    {
        return new DispatchedEventMatcher(value);
    }
}