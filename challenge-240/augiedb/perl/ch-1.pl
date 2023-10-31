#!/usr/bin/perl
use warnings;
use strict;

##
## Just wanted to highlight a one-line solution to the problem.
## I'm not rigging up a main() and a series of tests.
## Trust me; it works. =)
##

my @string = ("Perl", "Python", "Pascal");
my $chk = "ppp";

print $chk eq join('', map { lc( substr($_, 0, 1) ) } @string ) ? "True" : "False";

