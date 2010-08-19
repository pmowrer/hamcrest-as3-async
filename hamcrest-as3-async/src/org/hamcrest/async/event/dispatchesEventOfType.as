package org.hamcrest.async.event
{
	public function dispatchesEventOfType(value:String):EventDispatchedAsyncMatcher
	{
		return new EventDispatchedAsyncMatcher(value);
	}
}