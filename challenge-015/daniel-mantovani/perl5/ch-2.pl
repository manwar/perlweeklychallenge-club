# Write a script to implement Vigenère cipher.
# The script should be able encode and decode.
# Checkout wiki page for more information.

use strict;
use warnings;
use v5.10;

# Vigenère cipher works only with ascii uppercase letters, no
# spaces, control chars, etc
#

# we will receive 3 arguments, a direction that could be E for encrypt
# or D for decript, a keyword and the string to encode / decode:

my ( $dir, $key, $string ) = @ARGV[ 0 .. 2 ];

die
"Usage: $0 <E/D> <keyword> <string>\nwith both keyword and string a sequence of uppercase plain english letters"
  unless $dir
  && $dir =~ /^(e|d)$/i
  && $key
  && $key =~ /^([A-Z])+$/
  && $string
  && $string =~ /^([A-Z])+$/;

# we start by defining two arrays, for the keyword and the text
# the arrays will have integers from 0 to 25, representing upper
# case letters from A to Z

my @keyword = map { ord($_) - 65 } split '', $key;
my @text    = map { ord($_) - 65 } split '', $string;

# we should repeat keyword letters until we match text size, but
# we are not gonna do that, we just use module arithmetic to get
# the same effect, using keyword length as the module

my @result;

# encrypting is just adding text and keyword values, and
# decrypting would be the opposite, just substract keyword
# values from text
# so we define a sign variable to take care of that

my $sign = 1;    # encryption case
$sign = -1 if $dir =~ /d/i;

# now we do encryption or decryption letter by letter
for my $i ( 0 .. $#text ) {
    $result[$i] = $text[$i] + $sign * $keyword[ $i % @keyword ];
}

# and now we just print the result, after reconverting it
# to letters one by one

say join( '', map { chr( ( $_ % 26 ) + 65 ) } @result );

# example usage (examples from wikipedia page):
# ✘ $> perl ch-2.pl E LEMON ATTACKATDAWN
# LXFOPVEFRNHR
#  $> perl ch-2.pl D LEMON LXFOPVEFRNHR
# ATTACKATDAWN
#  $>
