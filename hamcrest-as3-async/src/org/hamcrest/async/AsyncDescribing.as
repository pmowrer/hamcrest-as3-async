package org.hamcrest.async
{
	import org.hamcrest.SelfDescribing;

	public interface AsyncDescribing extends SelfDescribing
	{
		function describeTimeoutTo(description:AsyncDescription):void;
	}
}