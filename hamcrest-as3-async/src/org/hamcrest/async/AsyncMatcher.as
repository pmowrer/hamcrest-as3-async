package org.hamcrest.async
{	
	import flash.events.IEventDispatcher;
	
	import org.hamcrest.Matcher;

	/**
	 * 
	 * @author Patrick Mowrer
	 * 
	 */	
	public interface AsyncMatcher extends AsyncDescribing
	{
		function callAsync(testCase:Object, target:Object, resultHandler:Function, timeoutHandler:Function):Matcher;
		function which(... rest):AsyncMatcher;
	}
}