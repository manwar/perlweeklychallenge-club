#!raku

#
# Perl Weekly Challenge 295
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-295>
#

sub MAIN( *@numbers where { @numbers.grep( * ~~ Int ).elems == @numbers.elems } ) {

    my ( $position ) = 0;
    my $min-jumps = @numbers.elems + 1;
    for 0 ..^ @numbers.elems - 1 -> $index {
	$position = $index;
	my $jump-counter = $index;

	while ( $position < @numbers.elems - 1 ) {
	    my $jump = @numbers[ $position ];
	    last if ! $jump;
	    $position += $jump;
	    $jump-counter++;
	}

	$min-jumps = $jump-counter if $jump-counter < $min-jumps && $position == @numbers.elems - 1;
    }

    $min-jumps.say and exit if ( $min-jumps < @numbers.elems );
    '1'.say;

}
