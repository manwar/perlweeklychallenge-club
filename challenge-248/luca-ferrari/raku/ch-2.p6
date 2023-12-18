#!raku

#
# Perl Weekly Challenge 248
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-248/>
#

sub MAIN() {
    my $a = [
              [1,  2,  3,  4],
              [5,  6,  7,  8],
              [9, 10, 11, 12]
    ];


    my $b = [];
    for 0 ..^ $a.elems - 1 -> $row {
	$b[ $row ].push: [];
	for 0 ..^ $a[ $row ].elems - 1 -> $col {
	    $b[ $row ][ $col ] = $a[ $row ][ $col ] + $a[ $row ][ $col + 1 ] + $a[ $row + 1 ][ $col ] + $a[ $row + 1 ][ $col + 1 ];
	}
    }

    $b.join( "\n" ).say;
}
