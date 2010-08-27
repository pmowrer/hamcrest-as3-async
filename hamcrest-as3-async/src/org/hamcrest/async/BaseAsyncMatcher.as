package org.hamcrest.async
{
    import flash.errors.IllegalOperationError;
    import flash.events.Event;
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
        
        protected var asyncHandler:Function;
        protected var eventType:String;      
        protected var timeout:int;
        
        public function BaseAsyncMatcher(eventType:String)
        {
            this.eventType = eventType;

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
        
        public final function callAsync(testCase:Object, untypedTarget:Object, successHandler:Function, failureHandler:Function):void
        {
            asyncHandler = Async.asyncHandler(testCase, successHandler, timeout, null, failureHandler);
            
            prepareTarget(untypedTarget).addEventListener(eventType, this.eventHandler, false, 0, true );  
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

        protected function eventHandler(event:Event):void
        {
            asyncHandler(event);
        }
    }
}