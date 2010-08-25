package org.hamcrest.test.async
{
    import mockolate.runner.MockolateRunner;
    import mockolate.verify;
    
    import org.hamcrest.async.AsyncDescription;
    import org.hamcrest.async.AsyncMatcher;
    import org.hamcrest.async.InvertedAsyncMatcher;
    import org.hamcrest.test.AbstractAsyncMatcherTestCase;

    [RunWith("mockolate.runner.MockolateRunner")]
    public class InvertedAsyncMatcherTest extends AbstractAsyncMatcherTestCase
    {		
        private var runner:MockolateRunner;
        
        private const IRRELLEVANT:Object = null;
        
        private var inverted:InvertedAsyncMatcher;
        
        [Mock]
        public var decorated:AsyncMatcher;
        
        [Before]
        public function setUp():void
        {
            inverted = new InvertedAsyncMatcher(decorated);            
        }
        
        [Test]
        public function swapsEventAndTimeoutHandlers():void
        {
            var eventHandler:Function = new Function();
            var timeoutHandler:Function = new Function();
            
            inverted.callAsync(this, IRRELLEVANT, eventHandler, timeoutHandler);
             
            verify(decorated).method("callAsync").args(this, IRRELLEVANT, timeoutHandler, eventHandler).once();            
        }
        
        [Test]
        public function swapsTimeoutDescriptionForRegularDescription():void
        {
            var timeoutDescription:AsyncDescription;
            
            inverted.describeTimeoutTo(timeoutDescription);
            
            verify(decorated).method("describeTo").once();   
            verify(decorated).method("describeTimeoutTo").never();
        }
        
        [Test]
        public function negatesRegularDescription():void
        {
            assertAsyncDescription("No ", inverted);    
        }
    }
}