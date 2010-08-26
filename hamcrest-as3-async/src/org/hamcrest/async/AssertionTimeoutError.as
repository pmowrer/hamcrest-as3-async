package org.hamcrest.async
{
    import org.hamcrest.AssertionError;
    
    public class AssertionTimeoutError extends Error
    {        
        public function AssertionTimeoutError(message:String)
        {
            super(message);
        }
    }
}