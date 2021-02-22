#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <path-to-file> <number>

use feature qw(signatures);
no warnings qw(experimental::signatures);

open my $fh, "<", $ARGV[0];
read $fh, my $txt, $ARGV[1];
say $txt;
    
