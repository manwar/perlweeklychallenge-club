#!/usr/bin/env perl

# Perl Weekly Challenge 326 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-326/

use Modern::Perl;
use POSIX qw(mktime);

@ARGV==1 or die "usage: $0 yyy-mm-dd\n";
my($y, $m, $d) = split /-/, $ARGV[0];
my $epoch = mktime(0, 0, 0, $d, $m - 1, $y - 1900);
my $yday = (localtime($epoch))[7] + 1;
say $yday;
