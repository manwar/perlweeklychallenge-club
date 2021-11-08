#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <space-separated digits>

my $attemptedOut = (join "", sort {$b cmp $a} @ARGV) =~ s/(.)([13579]*)$/$2$1/r;
say(($attemptedOut =~ m/[02468]$/) ? ($attemptedOut) : ("No even digits.."));
