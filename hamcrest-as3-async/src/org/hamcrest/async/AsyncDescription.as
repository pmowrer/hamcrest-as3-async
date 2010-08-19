package org.hamcrest.async
{
    import org.hamcrest.Description;
    
    /**
     * 
     * @author Patrick Mowrer
     * 
     */	
    public interface AsyncDescription extends Description
    {
        function appendTimeoutDescriptionOf(value:AsyncDescribing):AsyncDescription;
    }
}