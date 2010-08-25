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
        
        protected var actualMatcher:Matcher;
        protected var timeout:int;
        protected var eventType:String;
        
        public function BaseAsyncMatcher(eventType:String)
        {
            this.eventType = eventType;
            timeout = DEFAULT_TIMEOUT;
            actualMatcher = isTruthy();
        }
        
        public function describeTo(description:Description):void
        {
            throw new IllegalOperationError("BaseAsyncMatcher#description must be overriden by sub-class.");			
        }
        
        public function describeTimeoutTo(timeoutDescription:AsyncDescription):void
        {
            throw new IllegalOperationError("BaseAsyncMatcher#timeoutDescription must be overriden by sub-class.");
        }
        
        public final function callAsync(testCase:Object, untypedTarget:Object, resultHandler:Function, timeoutHandler:Function):Matcher
        {
            handleEvent(testCase, prepareTarget(untypedTarget), eventType, resultHandler, timeoutHandler);
            
            return actualMatcher;
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
                                             resultHandler:Function, timeoutHandler:Function):void
        {
            Async.handleEvent(testCase, target, eventType, resultHandler, timeout, null, timeoutHandler);
        }
    }
}