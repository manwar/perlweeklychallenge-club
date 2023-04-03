#!/usr/bin/perl

# Challenge 185
#
# Task 2: Mask Code
# Submitted by: Mohammad S Anwar
#
# You are given a list of codes in many random format.
#
# Write a script to mask first four characters (a-z,0-9) and keep the rest as it
# is.
# Example 1
#
# Input: @list = ('ab-cde-123', '123.abc.420', '3abc-0010.xy')
# Output: ('xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy')
#
# Example 2
#
# Input: @list = ('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f')
# Output: ('xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f')

use Modern::Perl;

sub mask_code {
    my($code) = @_;
    $code =~ s/\w/\x01/ for 1..4;
    return $code =~ s/\x01/x/gr;
}

@ARGV or die "usage: ch-2.pl code...\n";
say join " ", map {mask_code($_)} @ARGV;
