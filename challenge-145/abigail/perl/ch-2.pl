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
# Run as: perl ch-2.pl < input-file
#

#
# Once again, there is a choice to be made. The maker of the challenge
# gives us two, conflicting, options:
#
#    "Do as I say"
#
# and
#
#    "Do as I do"
#
#
# The challenge *description* asks us to create a *Palindromic Tree*,
# linking to a blog describing the elaborate graph structure (and the
# algorithm to create it) which is a Palindromic Tree.
#
# The challenge *examples* complete ignores the requirement of a 
# palindromic tree, heck, doesn't even bother to create anything 
# which even remotely looks like any kind of graph or other form of
# datastructure, and just outputs all palindromic substrings of
# the input, with duplicates removed.
#
# Sigh.
#
# Conflicting challenges like this push me ever further to the point
# of abandoning the weekly challenges. I'm very close to the edge.
#

#
# We'll be doing the "do as I do" option.
#

#
# Please see the section "Unicode and Combining Characters" at
# https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-145-2.html
# to see how we interpret a palindrome.
#

local $, = $";
while (<>) {
    my %seen;
    /(.+)(?{$seen {$1} ++ if $1 eq reverse $1})(*FAIL)/;
    #
    # Do we need to keep the order in which the palindromes
    # appear in the word? The examples do, but the description
    # is, (obviously, because the description bares no resemblance
    # to the examples) silent about that.
    #
    # We'll judge that the order appearing in the examples is an
    # artifact of the algorithm used to calculate the answers, and
    # not an requirement.
    #
    say keys %seen;
}
