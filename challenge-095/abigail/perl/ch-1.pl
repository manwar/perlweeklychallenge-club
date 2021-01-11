#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Run as "perl ch-1.pl < input-file"
# with one or more possible palidromes, each on their own line.
#

#
# A recursive definition of a palindrome:
#      - Empty, but followed by a digit          (1)
#      - A decimal dot, but followed by a digit  (1)
#      - A single digit
#      - A digit, followed by a palindrome, followed by the same digit
#
# (1) The "followed by a digit" is to prevent an empty string, or a 
#     a lone dot to be considered a palindrome.
#
# We also wrap the pattern into a script run assertion; this means we
# accept palindromes from different scripts -- but we don't allow mixing
# scripts. 
#
# That is, we accept
#      "\N{TAMIL DIGIT ONE}\N{TAMIL DIGIT TWO}\N{TAMIL DIGIT ONE}"
#
# But not 
#      "\N{TAMIL DIGIT ONE}\N{THAI DIGIT TWO}\N{TAMIL DIGIT ONE}"
#
# As the latter mixes digits from two different scripts.
#

binmode *STDIN, ':utf8';
say /^(*sr: (?<PAL> \.?(?=\d) | \d | (\d) (?&PAL) \g{-1}))$/x ? 1 : 0 while <>;

__END__
