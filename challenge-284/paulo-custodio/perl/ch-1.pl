#!/usr/bin/env perl

use Modern::Perl;

my @ints = @ARGV;
my %count;
$count{$_}++ for @ints;
my @lucky =
        sort {$b <=> $a}
        grep {$_ == $count{$_}} @ints;
say !@lucky ? -1 : $lucky[0];
