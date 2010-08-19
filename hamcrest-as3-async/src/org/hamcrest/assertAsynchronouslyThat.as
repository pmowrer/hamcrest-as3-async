package org.hamcrest
{
    import org.hamcrest.async.AsyncMatcher;
    
    /**
     * 
     * @author Patrick Mowrer
     * 
     */	
    public function assertAsynchronouslyThat(... rest):void
    {
        if (rest.length == 4 && rest[2] is AsyncMatcher)
        {
            assertAsynchronouslyThatMatcher(rest[0], rest[1], rest[2], rest[3]);
        }
        else if (rest.length == 3 && rest[1] is AsyncMatcher)
        {
            assertAsynchronouslyThatMatcher("", rest[0], rest[1], rest[2])
        }
        else
        {
            throw new ArgumentError("Insufficient arguments or incorrect types, received:", rest);
        }
    }
}
