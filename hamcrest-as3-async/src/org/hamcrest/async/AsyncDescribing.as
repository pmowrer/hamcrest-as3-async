package org.hamcrest.async
{
	import org.hamcrest.SelfDescribing;

	/**
	 * 
	 * @author Patrick Mowrer
	 * 
	 */	
	public interface AsyncDescribing extends SelfDescribing
	{
		function describeTimeoutTo(description:AsyncDescription):void;
	}
}