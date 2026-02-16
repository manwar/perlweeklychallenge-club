#!/usr/bin/env perl

use Modern::Perl;
use POSIX qw(mktime);

@ARGV==1 or die "usage: $0 yyy-mm-dd\n";
my($y, $m, $d) = split /-/, $ARGV[0];
my $epoch = mktime(0, 0, 0, $d, $m - 1, $y - 1900);
my $yday = (localtime($epoch))[7] + 1;
say $yday;
