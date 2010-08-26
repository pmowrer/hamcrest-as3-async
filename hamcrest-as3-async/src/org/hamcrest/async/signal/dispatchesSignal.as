package org.hamcrest.async.signal 
{
    /**
     * 
     * @author Patrick Mowrer
     * 
     */	
    public function dispatchesSignal():DispatchedSignalMatcher
    {
        return new DispatchedSignalMatcher();
    }
}