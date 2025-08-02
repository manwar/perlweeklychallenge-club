#!raku

#
# Perl Weekly Challenge 261
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-261>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems } ) {
    my $result = @nums.sum -  @nums.map( *.comb ).flat.sort.sum;
    ( $result < 0 ?? $result * -1 !! $result ).say;
}
