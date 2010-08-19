package org.hamcrest.async
{
	import org.hamcrest.Description;
	
	public interface AsyncDescription extends Description
	{
		function appendTimeoutDescriptionOf(value:AsyncDescribing):AsyncDescription;
	}
}