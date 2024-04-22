#!raku

#
# Perl Weekly Challenge 266
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-266>
#

sub MAIN() {

    my @matrix = [1, 0, 0, 2],
                 [0, 3, 4, 0],
                 [0, 5, 6, 0],
                 [7, 0, 0, 1],
    ;


    my @indexes;
    my $size = @matrix[ 0 ].elems;
    for 0 ..^ $size {
	@indexes.push: [ $_, $_  ];            # main diagonal
	@indexes.push: [ $_, $size - $_ - 1 ]; # antidiagonal
    }

    my $row-index = 0;
    for @matrix -> $row {
	my @zeros = $row.grep( { $_ != 0 }, :k ).map( { [ $row-index, $_ ] } );

	say 'False' and exit if @zeros.elems != $size / 2;
	say 'False' and exit if @indexes.grep( * eq any( @zeros ) ).elems != @zeros.elems;

	$row-index++;
    }

    'True'.say;
}
