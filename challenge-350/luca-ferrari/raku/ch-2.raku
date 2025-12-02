#!raku

#
# Perl Weekly Challenge 350
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-350>
#

sub MAIN( Int $from, Int $to, Int $count
	where { $to > $from && $count >= 1 } ) {

    my %found-pairs;
    for $from .. $to -> $current {
	my @pairs = $current.comb.permutations
		     .map( *.join.Int )
		     .grep( * > $current )
		     .grep( * %% $current );


	next if ! @pairs;
	%found-pairs{ $current } = @pairs;

    }

    %found-pairs.values.elems.say;
}

