package org.hamcrest.test.integration.org.flexunit.async
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    import org.flexunit.assertThat;
    import org.flexunit.async.Async;
    import org.hamcrest.core.isA;
    import org.hamcrest.object.equalTo;

    public class AsyncAssumptionsTest
    {        
        [Test(async)]
        public function eventHandlerReceivesTwoArgumentsTheFirstOfWhichIsAnEventObject():void
        {
            var dispatcher:EventDispatcher = new EventDispatcher();
            
            Async.handleEvent(this, dispatcher, "event", eventHandler, 1);
            
            function eventHandler():void
            {
                assertThat(arguments.length, equalTo(2));
                assertThat(arguments[0], isA(Event));
            }
            
            dispatcher.dispatchEvent(new Event("event"));
        }
       
        [Test(async)]
        public function timeoutHandlerReceivesOneArgument():void
        {
            const IRRELEVANT_FUNCTION:Function = new Function();
        
            Async.asyncHandler(this, IRRELEVANT_FUNCTION, 1, null, timeoutHandler);
            
            function timeoutHandler():void
            {
                assertThat(arguments.length, equalTo(1));
            }
        }
    }
}