use LinkedList::Simple;

multi sub MAIN( Bool :$t )
{
	test();
}

multi sub MAIN( Int:D :$k, *@n where { .elems > 1 && .all ~~ Int } )
{
	say LinkedList::Simple
		.from( |@n )
		.roughsort( * < $k )
		.flat
		.join( '→' );
}

sub test
{
	use Test;

	my %tests =
		'2-5-6-7-13-14-18'    => [ 10, ( 2, 5, 13, 14, 6, 7, 18 ) ],
		'2-5-6-7-13-14-18'    => [ 10, ( 13, 2, 5, 14, 6, 7, 18 ) ],
		'1-2-3-4-11-12-13-14' => [ 10, ( 1, 11, 2, 12, 3, 13, 4, 14 ) ],
		'1-1-1-1-2-2-2-2'     => [ 2,  ( 1, 2, 1, 2, 1, 2, 1, 2 ) ],
		'1-2-2-4-3-5'         => [ 3,  ( 1, 4, 3, 2, 5, 2 ) ]
	;

	my &test = {
		ok LinkedList::Simple
			.from( $^test.value[1].flat )
			.roughsort( * < $^test.value[0] )
			.flat
			.join('-') eq $^test.key, $^test.key }
	;

	.&test for %tests;
}
