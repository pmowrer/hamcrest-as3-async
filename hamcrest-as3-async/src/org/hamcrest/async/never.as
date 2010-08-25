package org.hamcrest.async
{
    public function never(matcher:AsyncMatcher):AsyncMatcher
    {
        return new InvertedAsyncMatcher(matcher);
    }
}