#!raku

#
# Perl Weekly Challenge 270
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-270>
#

sub MAIN() {
    my @matrix =  [1, 0, 0],
                  [0, 0, 1],
                  [1, 0, 0],
    ;

    my @ones;
    for 0 ..^ @matrix.elems -> $row {
	@ones.push: @matrix[ $row ].grep( { $_ == 1 }, :k ).map( { $row, $_, '%02d-%02d'.sprintf( $row, $_ )  } ).flat;
    }


    for @ones -> $current_one {
	$current_one[ 0, 1 ].join( ',' ).say if @ones.grep( {  $current_one[ 2 ] ne $_[ 2 ] && ( $_[ 1 ] == $current_one[ 1 ] || $_[ 0 ] == $current_one[ 0 ] ) } ).elems == 0
    }

}
