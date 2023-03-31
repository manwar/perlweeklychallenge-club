#!/usr/bin/perl

# Challenge 185
#
# Task 1: MAC Address
# Submitted by: Mohammad S Anwar
#
# You are given MAC address in the form i.e. hhhh.hhhh.hhhh.
#
# Write a script to convert the address in the form hh:hh:hh:hh:hh:hh.
# Example 1
#
# Input:  1ac2.34f0.b1c2
# Output: 1a:c2:34:f0:b1:c2
#
# Example 2
#
# Input:  abc1.20f1.345a
# Output: ab:c1:20:f1:34:5a

use Modern::Perl;

@ARGV==1 or die "usage: ch-1.pl mac\n";
say $ARGV[0] =~ s/^(\w\w)(\w\w)\.(\w\w)(\w\w)\.(\w\w)(\w\w)$/$1:$2:$3:$4:$5:$6/r;
