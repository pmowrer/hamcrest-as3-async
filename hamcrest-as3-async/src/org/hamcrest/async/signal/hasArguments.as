package org.hamcrest.async.signal
{
	import org.hamcrest.Matcher;

	public function hasArguments(... rest):Matcher
	{			
		var argumentMatchers:Array = rest.map(wrapInEqualToIfNotMatcher);
			
		return new SignalArgumentsMatcher(argumentMatchers);		
	}
}

import org.hamcrest.Matcher;
import org.hamcrest.object.equalTo;

internal function wrapInEqualToIfNotMatcher(item:Object, i:int, a:Array):Matcher
{
	return item is Matcher ? item as Matcher : equalTo(item);
}	
