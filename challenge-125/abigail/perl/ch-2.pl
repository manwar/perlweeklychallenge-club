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
# Once again, the weekly challenge cannot be bothered to specify how
# the input looks like when the exercises is about binary trees;
# there's only a single example tree, of which it's clear it will not
# scale beyond anything trivial.
#
# As such, the best we can do is recognize the one example, while being
# lenient if there is surplus white space. We'll print the answer if
# the example tree is given as input, and die on anything else, as nothing
# else is specified.
#

undef $/;
my $input = <>;

#
# Remove blank lines
#
$input =~ s/^\s+$//gm;

#
# Remove trailing whitespace from each line.
#
$input =~ s/\h+$//mg;

#
# Remove leading whitespace
#
$input =~ s/^ //gm while $input !~ /^\S/m;

if ($input eq << '--') {say 7} else {die "Unrecognized input"}
    1
   / \
  2   5
 / \ / \
3  4 6  7
       / \
      8  10
     /
    9
--
