package org.hamcrest.async
{
    import flash.errors.IllegalOperationError;
    import flash.events.IEventDispatcher;
    
    import org.flexunit.async.Async;
    import org.hamcrest.Description;
    import org.hamcrest.Matcher;
    import org.hamcrest.core.AllOfMatcher;
    import org.hamcrest.object.isTruthy;
    
    /**
     * 
     * @author Patrick Mowrer
     * 
     */	
    public class BaseAsyncMatcher implements AsyncMatcher
    {	
        public static const DEFAULT_TIMEOUT:int = 500;
        
        protected var eventObjectMatcher:Matcher;
        protected var timeout:int;
        protected var eventType:String;
        
        public function BaseAsyncMatcher(eventType:String, eventObjectMatcher:Matcher)
        {
            this.eventType = eventType;
            this.eventObjectMatcher = eventObjectMatcher;

            timeout = DEFAULT_TIMEOUT;
        }
        
        public function describeTo(description:Description):void
        {
            throw new IllegalOperationError("BaseAsyncMatcher#description must be overriden by sub-class.");			
        }
        
        public function describeTimeoutTo(timeoutDescription:AsyncDescription):void
        {
            throw new IllegalOperationError("BaseAsyncMatcher#timeoutDescription must be overriden by sub-class.");
        }
        
        public final function callAsync(testCase:Object, untypedTarget:Object, successHandler:Function, failureHandler:Function):Matcher
        {
            handleEvent(testCase, prepareTarget(untypedTarget), eventType, successHandler, failureHandler);
            
            return eventObjectMatcher;
        }		
        
        public function beforeTimeoutAt(value:int):AsyncMatcher
        {
            timeout = value;
            
            return this;
        }
        
        protected function prepareTarget(value:Object):IEventDispatcher
        {
            throw new IllegalOperationError("BaseAsyncMatcher#prepareTarget must be overriden by sub-class.");			
        }
        
        protected final function handleEvent(testCase:Object, target:IEventDispatcher, eventType:String, 
                                             eventHandler:Function, timeoutHandler:Function):void
        {
            Async.handleEvent(testCase, target, eventType, eventHandler, timeout, null, timeoutHandler);
        }
    }
}