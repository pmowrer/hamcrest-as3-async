package org.hamcrest.async.signal 
{
    /**
     * 
     * @author Patrick Mowrer
     * 
     */	
    public function dispatchesSignal():SignalDispatchedAsyncMatcher
    {
        return new SignalDispatchedAsyncMatcher();
    }
}