#!raku

#
# Perl Weekly Challenge 229
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-229/>
#

sub MAIN() {
    my @array1 = 1, 1, 2, 4;
    my @array2 = 2, 4;
    my @array3 = 4;

    my %bag;
    %bag{ $_ }++ for @array1.unique;
    %bag{ $_ }++ for @array2.unique;
    %bag{ $_ }++ for @array3.unique;

    %bag.keys.grep( { %bag{ $_ } >= 2 } ).join( ',' ).say;
}
