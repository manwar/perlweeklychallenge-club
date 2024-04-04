#!raku

#
# Perl Weekly Challenge 263
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-263>
#

sub MAIN() {
    my $items1 = [ [1,1], [2,1], [3,2] ];
    my $items2 = [ [2,2], [1,3] ];

    my %quantities;
    %quantities{ $_[ 0 ] } += $_[ 1 ] for $items1.flat;
    %quantities{ $_[ 0 ] } += $_[ 1 ] for $items2.flat;

    %quantities.Array.say;
}
