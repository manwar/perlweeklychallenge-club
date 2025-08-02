#!raku

#
# Perl Weekly Challenge 262
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-262>
#

sub MAIN( Int $k where { $k != 0 },
	  *@nums where { @nums.grep( * ~~ Int ).elems == @nums.elems } ) {

    my @pairs;

    for 0 ..^ @nums.elems -> $i {
	for $i ^..^ @nums.elems -> $j {
	    next if ( $i * $j ) !%% $k;
	    next if @nums[ $i ] != @nums[ $j ];
	    @pairs.push: [ $i, $j ];
	}
    }

    @pairs.elems.say;
}
