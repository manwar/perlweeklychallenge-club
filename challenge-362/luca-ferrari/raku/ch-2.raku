#!raku

#
# Perl Weekly Challenge 362
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-362>
#

sub MAIN( *@nums where { @nums.grep( * ~~ Int ).elems == @nums.elems } ) {
    my %symbols =
		  0 => 'zero',
		  1 => 'one',
		  2 => 'two',
		  3 => 'three',
		  4 => 'four',
		  5 => 'five',
		  6 => 'six',
		  7 => 'seven',
		  8 => 'eight',
		  9 => 'nine',
		  10 => 'ten',
		  11 => 'eleven',
		  12 => 'twelve',
		  13 => 'thirteen',
		  14 => 'fourteen',
		  15 => 'fifteen',
		  16 => 'sixteen',
		  17 => 'seventeen',
		  18 => 'eighteen',
		  19 => 'nineteen',
		  20 => 'twenty',
    ;

    my @phonetic;

    for @nums {
	my $current = 'plus ';

	if ( $_.Int < 0 ) {
	    $current = 'minus ';
	}

	my $value = $_.Int.abs;
	my $x;
	if ( $value >= 1000 ) {
	    ( $x, $value ) = $value / 1000, $value % 1000;
	    $current ~= ' ' ~ %symbols{ $x.Int } ~  ' thousands'
	}


	if ( $value >= 100 ) {
	    ( $x, $value ) = $value / 100, $value % 100;
	    $current ~= ' ' ~ %symbols{ $x.Int } ~  ' hundreds'
	}

	if ( $value > %symbols.keys.max ) {
	    ( $x, $value ) = $value / 10, $value % 10;
	    $current ~= ' ' ~ %symbols{ $x.Int } ~  'y'
	}

	if ( $value <= %symbols.keys.max ) {
	    $current ~= ' ' ~ %symbols{ $value.Int };
	}


	@phonetic.push: $current;
    }

    @phonetic.sort.join( "\n" ).say;

}
