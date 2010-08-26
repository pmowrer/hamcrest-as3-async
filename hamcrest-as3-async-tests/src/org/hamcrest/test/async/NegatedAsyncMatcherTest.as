package org.hamcrest.test.async
{
    import mockolate.runner.MockolateRunner;
    import mockolate.verify;
    
    import org.hamcrest.async.AsyncDescription;
    import org.hamcrest.async.AsyncMatcher;
    import org.hamcrest.async.EventObjectMatcher;
    import org.hamcrest.async.NegatedAsyncMatcher;
    import org.hamcrest.test.AbstractAsyncMatcherTestCase;

    [RunWith("mockolate.runner.MockolateRunner")]
    public class NegatedAsyncMatcherTest extends AbstractAsyncMatcherTestCase
    {		
        private var runner:MockolateRunner;
        
        private const IRRELLEVANT:Object = null;
        
        private var negated:NegatedAsyncMatcher;
        
        [Mock]
        public var decorated:EventObjectMatcher;
        
        [Before]
        public function setUp():void
        {
            negated = new NegatedAsyncMatcher(decorated);            
        }
        
        [Test]
        public function swapsSuccessAndFailureEventHandlers():void
        {
            var successHandler:Function = new Function();
            var failureHandler:Function = new Function();
            
            negated.callAsync(this, IRRELLEVANT, successHandler, failureHandler);
             
            verify(decorated).method("callAsync").args(this, IRRELLEVANT, failureHandler, successHandler).once();            
        }
        
        [Ignore("Not sure about this behavior")]
        public function swapsTimeoutDescriptionForRegularDescription():void
        {
            var timeoutDescription:AsyncDescription;
            
            negated.describeTimeoutTo(timeoutDescription);
            
            verify(decorated).method("describeTo").once();   
            verify(decorated).method("describeTimeoutTo").never();
        }
        
        [Test]
        public function negatesRegularDescription():void
        {
            assertAsyncDescription("No ", negated);    
        }
    }
}