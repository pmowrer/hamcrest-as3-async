package org.hamcrest.async
{
	import org.hamcrest.StringDescription;

	/**
	 * 
	 * @author Patrick Mowrer
	 * 
	 */	
	public class AsyncStringDescription extends StringDescription implements AsyncDescription
	{
		public function AsyncStringDescription()
		{
			super();
		}
		
		public function appendTimeoutDescriptionOf(value:AsyncDescribing):AsyncDescription
		{
			value.describeTimeoutTo(this);
			
			return this;
		}
	}
}