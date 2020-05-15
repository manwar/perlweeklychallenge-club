#! /opt/local/bin/perl
#
#       excellent_columns.pl
#
#         PWC 60 TASK #1 › Excel Column
#         Reviewed by: Ryan Thompson
#             Write a script that accepts a number and returns the Excel Column
#             Name it represents and vice-versa.
#
#             Excel columns start at A and increase lexicographically using the 26
#             letters of the English alphabet, A..Z. After Z, the columns pick up
#             an extra “digit”, going from AA, AB, etc., which could (in theory)
#             continue to an arbitrary number of digits. In practice, Excel sheets
#             are limited to 16,384 columns.
#
#             Example
#
#             Input Number: 28 Output: AB
#
#             Input Column Name: AD Output: 30
#
#         METHOD
#
#             So it’s base 26, using capital letters for the symbols. Cool.
#
#             Ok, well, sort of. Turns out it’s a little different, a little
#             more complicated than that.
#
#             “How so?” you say. Glad you asked. It seems we have a little
#             problem with Z.
#
#             “Z?” you say. Yes, Z.
#
#             As usual, the first order of business is to unpack the challenge
#             and nail down a few outstanding questions. Then the problem will
#             make a little more sense.
#
#             All we are told in the text about Excel is that the column
#             identifiers start with A and continue through Z, then recommence
#             labelling with AA to AZ, etcetera. In order for the mapping 28 →
#             AB to occur, 27 maps to AA, and what’s left is A-Z mapping to 1 to
#             26. So the indexing starts at 1. Fair enough.
#
#             The cycle is undoubtably 26; converting to base 26 seems a
#             reasonable start. We can then substitute the letters A-Z for the
#             normal representation 0-9 followed by A-P. The problems start
#             immediately, with the number 1026, or if you look at it another
#             way, 0.
#
#             To make visualization a little easier it might make sense to
#             relate to base 10, our standard counting system. To count in base
#             10, we use the 10 digits 0 through 9, then we start to
#             positionally combine these digits to make the numbers 10, 11, and
#             so on. So if we choose to use letters for our digits, do we map
#             the letters to 0-9 or 1-10? In either case we are confounded by
#             10, being the last member of the mapping, but being composed of
#             two digits in the number system.
#
#             But back to base 26 and Z, if we use the tried and true method of
#             dividing out the base, we’ll never get a remainder of 26, but
#             rather 0. So do we make 0 → Z ? Then 26 → AZ, which is wrong. Z
#             has to be 26, because the next number, 27 is AA (think 11 here if
#             you must, the association is correct) Similarly, fudging our
#             numbers by 1 in other ways, either reducing the input or the
#             remainder to match 0 indexing fails as well, either starting on
#             the wrong letter or erring at the transition to two digits.
#             Sometimes we start at B, or later we get BA instead of AA. There’s
#             a lot of ways down this mountain, I assure you. We are being
#             confounded by the fact that our counting is indexed to 1 and our
#             base is indexed to 0.
#
#             The solution is to shift the input number to a 0-based lookup
#             within the dividing out itself, by subtracting 1 from the number
#             during the computation of the remainder. Then 26 becomes 25 and
#             the arithmetic all works out; 27 follows 26 as it should be and AA
#             follows Z. This gives us the correct translation, finally. Mixing
#             indexing systems is always a red flag for danger, and adding in
#             modular arithmetic to the mix just adds to the confusion.
#
#             To do the conversion from Excel to decimal is a little less
#             complicated, fortunately for us. To run the dividing out in
#             reverse we first need to establish a lookup mapping the letters
#             A-Z to 1-26, and then we progress through the string taking off
#             letters from the right and summing the product of the lookup value
#             and 26 to the power of the (0-based) position for each place. In
#             base-10, this multiplier is 1, 10, 100 and so on. In base-26 we
#             use 26^0, 26^1, 26^2… To implement this, we dice the string into
#             an array of chars, reverse() the array and shift() from the left.
#             Then we can keep track of the loops, counting from 0, to get the
#             appropriate power.
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my ($input, $EXAMPLE) = @ARGV;

if    ($input =~ /^\d*$/) {
    say dec2excel($input);
}
elsif ($input =~ /^[A-Z]*$/) {
    say excel2dec($input);
}
else {
    say "input: decimal number or capital alphabetic sequence of characters A-Z";
}

$EXAMPLE && printf "%-2d  %-2s  %-2d  %-2s\n", $_, dec2excel($_),
                            excel2dec(dec2excel($_)), b26($_) for (1..90);


## ## ## ## ## SUBS:

sub dec2excel {
    my $num = shift;
    my @alpha = ( "A".."Z" );
    my $out = "";
    my $rem = 0;
    while ( $num > 0  ) {
        ## magic here, note we do the math on num - 1
        ($num, $rem) = (int( ($num-1)/26 ), ($num-1) % 26);
        $out = $alpha[$rem] . $out;
    }
    return $out;

}

sub excel2dec {
    my $excel = shift;
    my @alpha = ( "A".."Z" );
    my %alpha = map { $alpha[$_] => $_+1 } (0..25);

    my @rev_26 = reverse( map { $alpha{$_} } split //, $excel );

    my $out;
    for (0..@rev_26 - 1) {
        my $val = shift @rev_26;
        $out += $val * (26 ** $_);
    }
    return $out;
}
