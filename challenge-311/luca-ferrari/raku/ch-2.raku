#!raku

#
# Perl Weekly Challenge 311
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-311>
#

sub MAIN( Str $digits, Int $size ) {
    $digits.comb.rotor( $size, :partial ).map( { [+] $_ } ).join.say;
}
