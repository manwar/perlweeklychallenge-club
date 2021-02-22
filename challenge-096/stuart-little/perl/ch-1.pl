#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <quoted string>

say join " ", (reverse grep /\w/, (split /\s+/, $ARGV[0]))
