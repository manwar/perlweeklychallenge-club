#! /opt/local/bin/perl
#
#       reverse-and-repeat.pl
#
#         TASK #1 › Reverse Integer
#         Submitted by: Mohammad S Anwar
#         You are given an integer $N.
# 
#         Write a script to reverse the given integer and print the result.
#         Print 0 if the result doesn’t fit in 32-bit signed integer.
# 
#         The number 2,147,483,647 is the maximum positive value for a 32-bit
#         signed binary integer in computing.
# 
#         Example 1:
#             Input: 1234
#             Output: 4321
#         Example 2:
#             Input: -1234
#             Output: -4321
#         Example 3:
#             Input: 1231230512
#             Output: 0
# 
#         method:
#             A complex idea with the abstract idea of a decimal number; a
#             simple dispatch if considered as a string. Fortunately for us,
#             Perl excels at this idea of a character representation holding a
#             dual personality. Mathematically speaking, the glyphs recorded in
#             a text aren't truly the numbers per se, only representations of
#             them. The symbolic representation can change; the numerical
#             essance remains outside of its physically recorded state.
# 
#             The positional decimal system using arabic numerals is globally
#             ubiquitous today but this has hardly been true throughout history.
#             Because of its practical linkage to the use of the abacus, the
#             Roman numeral system maintained dominance in mercantile accounting
#             well into the 14th or 15th century.*
# 
#             The merchants that used calculations daily preferred the physical
#             existence of a strike on a counting board or a bead on an abacus.
#             It was what they knew and it worked. Roman numerals held within
#             them a decimal core -- I, X, C, M for 1, 10, 100, 1000 -- but the
#             abstraction of of the glyphs was simpler,  referring back to a
#             unary base: "I" was one stick, "III" was three sticks and "X" was
#             the same as "IIIII IIIII". "V" was half of an "X", quite visually
#             expressed.
# 
#             Positional notation, on the other hand,  depended on the idea of
#             the zero as a placeholder, and practical as this idea might be in
#             the long run, the modern methods faced stubborn resistance from
#             the governments that held the merchant classes to account. It is
#             argued that the essence of the zero —- something that exists but
#             holds no value, signifying nothing; something there but also
#             somehow not there at the same time -- all this made the very idea
#             of its use at least suspicious, if not "Saracen sorcery". One
#             Venetian source wrote: "the old figures [i.e. Roman numerals]
#             alone are used because they cannot be falsified as easily as those
#             of the new art of computation"**
# 
#             Consider for a moment the tendered amount written out twice on a
#             check. These ideas even hold out through this day, that somehow
#             the written out words are more real than the numerical notation,
#             more unalterably defined by the sentence describing them than by
#             the numbers themselves. The textual phrasing anchors the abstract
#             and elusive mathematical realm to the real world of here and now.
# 
#             I believe you can still see the vestiges of this concreteness in
#             the COBOL programming language as well, but that's another story. 
                      
#             
#             ======================================
#             
#             * Durham, John W. “THE INTRODUCTION OF ‘ARABIC’ NUMERALS IN
#             EUROPEAN ACCOUNTING.” The Accounting Historians Journal, vol. 19,
#             no. 2, 1992, pp. 25–55. JSTOR, www.jstor.org/stable/40698081.
#             Accessed 27 Oct. 2020.
# 
#             ** Kaplan, Robert "The Nothing That Is" pp. 102 Oxford University
#             Press 1999
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


use 5.032;
use warnings;
use strict;

## ## ## ## ## MAIN:
##
## turning the tables served three ways:
##

my $def = 7463847412;

## 1. reverse

say '';
say "=" x 25;
say '';
say "the right way. Reverse the string:\n";


my $num = $ARGV[0] // $def;

my $sign = $num < 0 ? "-" : '';

my $out = $num =~ s/0+$//r;   ## strip trailing 0s before reversing
my $rev = $sign . reverse abs $out;

say "input:  $num";
say "output: ", -2147483648 <= $rev <= 2147483647 ? $rev : 0;

##--------------------------
## 2. positionally

say '';
say "=" x 25;
say '';
say "hard mode, done positionally:\n";

my $input = @ARGV[0] // $def; ##7463847412
   $num   = abs $input;
my $sign  = $input < 0 ? "-" : '';
my @positions;

while ($num) {
    unshift @positions, $num % 10;
    $num = int $num/10;
}

my $reversed = 0;
say "starting output = 0";
for my $power ( 0..$#positions ) {
    say "--> adding $positions[0] x 10^$power = ", 
        sprintf "%10d", $reversed + $positions[0] * (10 ** $power);   
    $reversed += (shift @positions) * (10 ** $power);
}
$reversed = $sign . $reversed;  ## prefix the sign

if (! -2147483648 < $reversed < 2147483647 ) {
    say "\nthe number $reversed cannot be fit into a 32-bit signed int\n";
} 

say '';
say "input : $input";
say "output: ", -2147483648 <= +$reversed <= 2147483647 ? $reversed : 0;


##----------------------------
## 3. mathematically

say '';
say "=" x 25;
say '';
say "hard mode, done mathematically:\n";

$input     = @ARGV[0] // $def;
$num       = abs $input;
$sign      = $input < 0 ? -1 : 1;
my $output = 0;

my $power = 0;
$power++ while int $num / 10 ** $power > 0;

while ($power--) {
    $output += $num % 10 * 10 ** $power ;    
    say $output;
    $num = int $num/10;
}
$output *= $sign;

say '';
say "input : $input";
say "output: ", -2147483648 <= $output <= 2147483647 ? $output : 0;

