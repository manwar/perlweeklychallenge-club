#!/usr/bin/env perl

# Challenge 162
#
# Task 1: ISBN-13
# Submitted by: Mohammad S Anwar
# Write a script to generate the check digit of given ISBN-13 code. Please
# refer wikipedia for more information.
#
# Example
# ISBN-13 check digit for '978-0-306-40615-7' is 7.

use Modern::Perl;
use Business::ISBN;

my $isbn = Business::ISBN->new(shift||"");
$isbn->fix_checksum;
say substr($isbn->as_string, -1, 1);
