#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Challenge:
#
#   You are given a DNA sequence composed of one of four nitrogen-containing
#   nucleobases cytosine (C), guanine (G), adenine (A) and thymine (T).
#
#   Print the number of nucleiobases in the DNA sequence, and print the
#   complementary sequence, where each T is replaced by an A, each A by a
#   T, each G by a C, and each C by a G.
#

#
# This is really trivial to do in Perl. y/// replaces letters by letters,
# and return the number of replacements -- since we're replacing all letters
# this is the required length.
#

print y/TAGC/ATCG/, "\n", $_ while <>;

__END__
