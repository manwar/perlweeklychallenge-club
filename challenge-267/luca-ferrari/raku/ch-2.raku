#!raku

#
# Perl Weekly Challenge 267
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-267>
#
# You are given a string, $str, and a 26-items array @widths containing the width of each character from a to z.

# Write a script to find out the number of lines and the width of the last line needed to display the given string, assuming you can only fit 100 width units on a line.
# Example 1

# Input: $str = "abcdefghijklmnopqrstuvwxyz"
#        @widths = (10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10)
# Output: (3, 60)

# Line 1: abcdefghij (100 pixels)
# Line 2: klmnopqrst (100 pixels)
# Line 3: uvwxyz (60 pixels)


# Input: $str = "bbbcccdddaaa"
#        @widths = (4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10)
# Output: (2, 4)

# Line 1: bbbcccdddaa (98 pixels)
# Line 2: a (4 pixels)

sub MAIN( Str $string, *@widths where { @widths.elems == 26 && @widths.elems == @widths.grep( * ~~ Int ).elems } ) {

    my %pixels;
    my $index = 0;
    %pixels{ $_ } = @widths[ $index++ ] for 'a' .. 'z';


    $index = 0;
    my $lines = 1;
    my $pixels = 0;

    for $string.comb -> $letter {
	if ( $pixels + %pixels{ $letter } > 100 ) {
	    $lines++;
	    $pixels = 0;
	}

	$pixels += %pixels{ $letter };

    }

    ( $lines, $pixels ).join( ', ' ).say;
}
