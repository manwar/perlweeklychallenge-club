#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <number> <bit position>

say $ARGV[0] ^ 2 ** ($ARGV[1]-1);
