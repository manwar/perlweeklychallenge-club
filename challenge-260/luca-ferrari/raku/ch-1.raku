#!raku

#
# Perl Weekly Challenge 260
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-260>
#

sub MAIN( *@nums where { @nums.grep( * ~~ Int ).elems == @nums.elems } ) {
    my $bag = Bag.new( @nums );

    for $bag.values -> $current {
	'0'.say and exit if ( $bag.values.grep( * ~~ $current ).elems > 1 );
    }

    '1'.say;

}
