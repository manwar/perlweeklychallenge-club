sub MAIN( $target, *@list )
{
	@list.combinations(3).grep( *.sum == $target ).say;
}