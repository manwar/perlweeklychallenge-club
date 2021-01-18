#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <space-separated strings>

use Text::Levenshtein qw(distance);

say distance ($ARGV[0], $ARGV[1])
