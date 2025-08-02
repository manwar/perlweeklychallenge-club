#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-272/#TASK1
#
# Task 1: Defang IP Address
# =========================
#
# You are given a valid IPv4 address.
#
# Write a script to return the defanged version of the given IP address.
#
###  A defanged IP address replaces every period “.” with “[.]".
#
## Example 1
##
## Input: $ip = "1.1.1.1"
## Output: "1[.]1[.]1[.]1"
#
## Example 2
##
## Input: $ip = "255.101.1.0"
## Output: "255[.]101[.]1[.]0"
#
############################################################
##
## discussion
##
############################################################
#
# There are two pretty simple approaches here. Either substitute
# all "." with "[.]" directly, or split the string at "." and
# join it using "[.]" as the glue. Both work fine.

use strict;
use warnings;

defang_ip_address("1.1.1.1");
defang_ip_address("255.101.1.0");

sub defang_ip_address {
   my $ip = shift;
   print "Input: $ip\n";
   $ip =~ s/\./\[.\]/g;
   # or:
   # $ip = join("[.]", split/\./, $ip);
   print "Output: $ip\n";
}

