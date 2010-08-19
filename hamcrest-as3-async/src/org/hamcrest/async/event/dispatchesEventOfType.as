package org.hamcrest.async.event
{
	import flash.events.IEventDispatcher;

	public function dispatchesEventOfType(value:String):EventDispatchedAsyncMatcher
	{
		return new EventDispatchedAsyncMatcher(value);
	}
}