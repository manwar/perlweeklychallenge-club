#!/usr/bin/env perl
#===============================================================================
#
#        USAGE: ./ch-2.pl linewidth
#
#  DESCRIPTION: wrap STDIN at the specified linewidth, preserving newlines
#
#===============================================================================

use strict;
use warnings;
use Text::Wrap qw/$columns wrap/;

die "The linewidth is required as the argument\n"
    unless defined $ARGV[0];

($columns) = $ARGV[0] =~ /^([0-9]+)$/g;
die "The supplied linewidth ($ARGV[0]) isn't a natural number\n"
    unless $columns;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';
print wrap ('', '', <STDIN>);
