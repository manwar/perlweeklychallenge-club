#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl
#

#
# This is a trivial exercise -- as all exercises are which do not
# take any input, and which have a fixed output. Fixed output
# challenges are boring -- unless there's another condition (golf,
# for instance).
#
# This exercise is so trivial, we don't even have to head to the OEIS
# to download the wanted numbers, as the expected output is stated
# in the exercise.
#
# So, all we need to do is print three numbers, separated by commas.
#
# The easiest way would be to just do what the challenge demands
# from us, and print the output as given.
#
# A slightly less easy way would be to head over the given Wikipedia
# page (or the OEIS for that matter), copy the first three numbers,
# and print those out.
#
# But those solutions no doubt will cause scorn in two weeks,
# when the review comes out. It's all "advice about the code is the thing".
#
# But that raises the question, what is the code which is wanted? 
# You could generate all the numbers of length b in base b, while
# increasing b, test them for being self-descriptive, and print 
# the first three numbers found.
#
# My advice about brute force code when there is a more efficient way:
# Don't ever do that.
#
# If we just imagine the Wikipedia page didn't list any self-descriptive
# numbers, and Neil Sloane has forgotten to pay the fee for the OEIS
# domain, so it was taken off-line, then it's still easy to determine
# the first three self-descriptive numbers -- no code required.
#
# Given the following observations for a self-descriptive number N in base b:
#  - N has b digits, and does not start with a 0.
#  - The sum of the digits of N is b.
#  - No digit of N equals b - 1.
#  - The last digit of N is 0.
#  - If b > 4, then N does not start with a 1.
#  - If b > 4, then N does not start with b - 2.
#
# From that, it's easy to determine that:
#  - There are no self-descriptive numbers in any base below 4.
#  - A self-descriptive number in base 4 must start with a 1 or 2. And
#    end with a 0. If it starts with a 1, the middle digits are 1 and 2.
#    If it starts with a 2, the middle digits are 0 and 2. Both "1210",
#    and "2020" are self-descriptive numbers.
#  - A self-descriptive number in base 5 must start with a 2, and end
#    with a 0. The three middle digits must be 0, 1, and 2. "21200"
#    is a self-descriptive number.
#
# (For a more detailed derivation, with all the details filled in,
#  see the blog post at
#  https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-107-1.html)
#
# But this still makes this challenge a glorified "Hello, World!"
# program, as there is no useful code to write to generate the numbers.
#

say "1210, 2020, 21200";
