#!raku

#
# Perl Weekly Challenge 357
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-357>
#

sub MAIN( Int $numerator where { $numerator > 1 } ) {

    my @nums = 1 .. $numerator [X] 1 .. $numerator;
    my %values;
    for @nums {
	my ( $n, $d ) = $_[ 0 ], $_[ 1 ];
	%values{ $n / $d }.push: "$n/$d";
    }


    %values{ $_ }.sort()[ 0 ].say for %values.keys.sort;


}
