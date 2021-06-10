#!/usr/bin/perl
# The Weekly Challenge - 038 
# Task 1 Date Finder
# attempt: May 09th, 2021
# from: C.-Y. Fung
# Usage: ch-1.pl [7-digit string]
# Java correspondence: DateFinder.java
use Time::Piece;
use strict;
use warnings;

my $str = $ARGV[0] || die "A 7-digit string is expected.";
die "Format Error: A 7-digit string is expected." if length $str != 7;

$str =~ s/^1/20/;
$str =~ s/^2/19/;
die "Error: first digit must be 1 or 2! " if $str =~ /[^12]/;

my $Y = substr($str, 0, 4);
my $Month = substr($str, 4, 2);
my $d = substr($str, 6, 2);

die "Problem in month ($Month)! " 
    if $Month > 12 || $Month < 1;
my $check = Time::Piece->strptime(substr($str,0,6)."01" , "%Y%m%d"); 
die "Problem in date (last two digits: $d)! " 
    if $d > $check->month_last_day || $d < 1;

my $t = Time::Piece->strptime($str, "%Y%m%d"); 


print $t->strftime("%Y-%m-%d"), "\n";
