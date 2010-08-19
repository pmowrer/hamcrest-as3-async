package org.hamcrest
{	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import org.hamcrest.async.AsyncDescription;
	import org.hamcrest.async.AsyncMatcher;
	import org.hamcrest.async.AsyncStringDescription;

    /**
     * Used internally by <code>assertAsynchronouslyThat</code>.
     *
     * @param reason Description of failure should <code>actual</code> not match <code>matcher</code>
     * @param actual Object to match
     * @param matcher Matcher to match <code>actual</code> with.
     *
     * @author Patrick Mowrer
     */
    internal function assertAsynchronouslyThatMatcher(reason:String, target:IEventDispatcher, 
													  asyncMatcher:AsyncMatcher, testCase:Object):void
    {		
		var matcher:Matcher = asyncMatcher.callAsync(testCase, target, resultHandler, timeoutHandler);
		
		var errorDescription:AsyncDescription = new AsyncStringDescription();
		var matcherDescription:AsyncDescription = new AsyncStringDescription();
		var mismatchDescription:AsyncDescription = new AsyncStringDescription();
		
		function resultHandler(event:Event, data:Object):void 
		{			
			if(!matcher.matches(event))
			{	
				if (reason && reason.length > 0)
				{
					errorDescription
					.appendText(reason)
						.appendText("\n");
				}
				
				errorDescription
				.appendText("Expected: ")
					.appendDescriptionOf(matcher)
					.appendText("\n     but: ")
					.appendMismatchOf(matcher, event);
				
				matcherDescription.appendDescriptionOf(matcher);
				
				mismatchDescription.appendMismatchOf(matcher, event);
				
				throw new AssertionError(
					errorDescription.toString(), 
					null, 
					matcherDescription.toString(), 
					mismatchDescription.toString(), 
					event);
			}
		}
		
		function timeoutHandler():void 
		{	
			if (reason && reason.length > 0)
			{
				errorDescription
				.appendText(reason)
					.appendText("\n");
			}
						
			errorDescription
			.appendText("Expected: ")
				.appendDescriptionOf(asyncMatcher)
				.appendText("\n     but: ");
			
			(errorDescription as AsyncDescription).appendTimeoutDescriptionOf(asyncMatcher);
			
			throw new AssertionError(
				errorDescription.toString());			
		}
		
        /*if (!matcher.matches(actual))
        {
			var errorDescription:Description = new BetterStringDescription();
            var matcherDescription:Description = new BetterStringDescription();
			var mismatchDescription:Description = new BetterStringDescription();

            if (reason && reason.length > 0)
            {
				errorDescription
                    .appendText(reason)
                    .appendText("\n");
            }

			errorDescription
                .appendText("Expected: ")
                .appendDescriptionOf(matcher)
                .appendText("\n     but: ")
                .appendMismatchOf(matcher, actual);

			matcherDescription.appendDescriptionOf(matcher);
			
			mismatchDescription.appendMismatchOf(matcher, actual);
				
            throw new AssertionError(
				errorDescription.toString(), 
				null, 
				matcherDescription.toString(), 
				mismatchDescription.toString(), 
				actual);
        }*/
    }
}
