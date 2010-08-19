package org.hamcrest.async
{	
	import flash.events.IEventDispatcher;
	
	import org.hamcrest.Matcher;

	public interface AsyncMatcher extends AsyncDescribing
	{
		function callAsync(testCase:Object, target:Object, resultHandler:Function, timeoutHandler:Function):Matcher;
	}
}