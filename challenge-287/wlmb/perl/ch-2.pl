#!/usr/bin/env perl
# Perl weekly challenge 287
# Task 2:  Valid Number
#
# See https://wlmb.github.io/2024/09/16/PWC287/#task-2-valid-number
use v5.36;
my $re = qr/
   ^                # start of string
   (\+|-)?          # optional sign
   (\d+             # integer
    | \d+\.\d*      # or integer part and optional decimal part
    | \d*\.\d+      # or optional integer part and decimal part
   )
   (                # exponent
    (e|E)           #   letter e or E
    (\+|-)?         #   optional sign
    \d+             #   integer exponent
   )?               # is optional
   $                # end of string
   /x;
say "$_ -> ", /$re/?"true":"false" for (@ARGV);
