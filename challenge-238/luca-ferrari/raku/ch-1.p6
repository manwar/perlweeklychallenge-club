#!raku

#
# Perl Weekly Challenge 238
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-238/>
#

sub MAIN( *@nums where { @nums.grep( * ~~ Int ).elems == @nums.elems } ) {
    my @running-sum;
    for 0 ..^ @nums.elems -> $index {
	@running-sum[ $index ] = [+] @nums[ 0 .. $index ];
    }

    @running-sum.join( ', ' ).say;
}
