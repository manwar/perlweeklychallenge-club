#!/usr/bin/env perl

# Challenge 146
#
# TASK #1 › 10001st Prime Number
# Submitted by: Mohammad S Anwar
# Write a script to generate the 10001st prime number.

use Modern::Perl;
use ntheory qw( nth_prime );
say nth_prime(10001);
