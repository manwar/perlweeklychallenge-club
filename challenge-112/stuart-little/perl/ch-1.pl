#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <path>

use Path::Resolve;

say Path::Resolve->new()->resolve($ARGV[0]);
