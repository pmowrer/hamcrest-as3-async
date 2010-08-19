package org.hamcrest.test.async.signal
{
	import org.hamcrest.test.AbstractMatcherTestCase;
	import org.osflash.signals.Signal;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.hamcrest.async.signal.hasArguments;

	public class HasArgumentsMatcherTest extends AbstractMatcherTestCase
	{
		[Test]
		public function matchesSignalAsyncEventWithGivenArguments():void
		{
			var event:SignalAsyncEvent = new SignalAsyncEvent("anything", ["string", 123]);
			
			assertMatches("", hasArguments("string", 123), event);
			assertDoesNotMatch("", hasArguments(123, "string"), event);
		}
		
		[Test]
		public function hasAReadableDescription():void
		{
			assertDescription(" with arguments [\"a\", \"b\", <3>]", hasArguments("a", "b", 3));
		}
		
		[Test]
		public function hasAReadableMismatchDescriptionForWrongNumberOfArguments():void
		{
			var event:SignalAsyncEvent = new SignalAsyncEvent("anything", ["string"]);
			
			assertMismatch(" was [\"string\"]", hasArguments(123, "string"), event);			
		}
		
		[Test]
		// hamcrest-as3 doesnt really lend itself to this sort of detailed mismatching, yet
		public function hasAReadableMismatchDescriptionForExpectedNumberOfArguments():void
		{
			var event:SignalAsyncEvent = new SignalAsyncEvent("anything", [123, "string"]);
			
			assertMismatch("\"string\"was <123>, <123>was \"string\"", hasArguments("string", 123), event);
		}
	}
}