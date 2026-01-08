#!raku

#
# Perl Weekly Challenge 355
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-355>
#

sub MAIN( *@ints where { @ints.grep( * ~~ Int ).elems == @ints.elems } ) {
    'False'.say and exit if ( @ints.elems < 3 );
    my $ok = False;
    for 1 ..^ @ints.elems -> $i {
	$ok =  @ints[ 0 .. $i ].sort.Array eqv @ints[ 0 .. $i ].Array
		&& @ints[ $i .. * - 1 ].sort( { $^b <=> $^a } ).Array eqv @ints[ $i .. * - 1 ].Array;
	last if ( $ok );
    }

    $ok.say;
}
