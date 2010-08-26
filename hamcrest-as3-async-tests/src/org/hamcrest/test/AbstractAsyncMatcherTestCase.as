package org.hamcrest.test
{
    import org.hamcrest.SelfDescribing;
    import org.hamcrest.async.AsyncDescribing;
    import org.hamcrest.async.AsyncDescription;
    import org.hamcrest.async.AsyncMatcher;
    import org.hamcrest.async.AsyncStringDescription;

    public class AbstractAsyncMatcherTestCase extends AbstractMatcherTestCase
    {
		private var description:AsyncDescription 
		
        public function assertAsyncDescription(expected:String, matcher:AsyncDescribing):void
        {
			description = new AsyncStringDescription();
            description.appendDescriptionOf(matcher);
			
            assertEquals("Expected description", expected, description.toString());
        }
		
		public function assertAsyncTimeoutDescription(expected:String, matcher:AsyncDescribing):void
		{
			description = new AsyncStringDescription();
			description.appendTimeoutDescriptionOf(matcher);
			
			assertEquals("Expected description", expected, description.toString());
		}
    }
}
