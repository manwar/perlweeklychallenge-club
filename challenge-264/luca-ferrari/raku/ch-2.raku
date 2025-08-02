#!raku

#
# Perl Weekly Challenge 264
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-264>
#

# example of invocation
# $ raku raku/ch-2.raku --source 0 --source 1 --source 2 --source 3 --source 4 --indexes 0 --indexes 1 --indexes 2 --indexes 2 --indexes 1
# 0 4 1 3 2

sub MAIN( :@source, :@indexes
		      where { @source.elems == @indexes.elems
						&& @indexes.min >= 0
						&& @indexes.max <= @source.elems } ) {

    my @target;

    for 0 ..^ @indexes.elems  {
	my $target-index = @indexes[ $_ ];
	if ! @target[ $target-index ] {
	    @target[ $target-index ] = @source[ $_ ];
	} else {
	    @target = |@target[ 0 .. $target-index - 1 ], @source[ $_ ], |@target[ $target-index  .. * ];
	}
    }

    @target.join( ' ' ).say;
}
