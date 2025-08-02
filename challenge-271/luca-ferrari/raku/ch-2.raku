#!raku

#
# Perl Weekly Challenge 271
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-271>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems } ) {
    my %bits;
    # convert numbers into an hash keyed by the binary representation
    %bits{ $_.base( 2 ).comb.grep( * ~~ 1 ).elems }.push: $_ for @nums;

    my @output;
    @output.push: |%bits{ $_ }.sort for %bits.keys.sort;
    @output.say;
}
