#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-140/#TASK1
#

#
# Run as: perl ch-1.pl < input-file
#

#
# This challenge is riddle with confusing directives. WTF is a 
# "decimal-coded binary number"? Searching for that term on
# Google just returns results for Binary-coded decimals, which
# are well known.
#
# Second point: "simulate the addition of the given binary numbers".
# Uhm, virtually every general purpose computer made in the past 
# 70 years does arithmetic using binary. Are we asked to simulate
# something which is already done? How? The examples just give answers,
# the answers are as closely related to spinach as they are to simulations.
#
# Third, it mentions operator overloading. Why? What? Without overloading
# binary "+" adds two numbers. We're asked to add two numbers. Why on earth
# would you want to overload an operator?
#

#
# As the description of the challenge is pretty pointless, we have to
# resort to extract the purpose:
#   - Give two binary numbers, add them, and print the result in binary
#
# Which means, this challenge is about translating to and from binary
# string representation. We use 'oct' for the latter, and sprintf for the
# former.
#
# This leaves us a one-liner:
#

say sprintf "%b" => eval join " + " => map {oct "0b$_"} split while <>;
