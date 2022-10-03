#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $in = shift;

my $hex_re = qr/[a-f0-9]/i;

die "$in is not a valid MAC address\n"
  unless $in =~ /^$hex_re{4}\.$hex_re{4}\.$hex_re{4}$/;

say join ':', $in =~ /($hex_re{2})/g;
