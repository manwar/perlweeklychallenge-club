#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Time::Local;

my $in = shift // '2230120';
die "Input should be seven digits\n" unless $in =~ /^\d{7}$/;

my ($y1, $y2, $m, $d) = $in =~ /^(\d)(\d\d)(\d\d)(\d\d)/;
die "First digit should be 1 or 2\n" if $y1 !~ /[12]/;
my $year = $y1 == 1 ? "20$y2" : "19$y2";
die "Digits 4 and 5 should be a valid month number\n" unless $m =~ /(0\d)|(1[012])/;
die "Digits 6 and 7 should be a valid day in month\n" unless $d =~ /([012]\d)|(3[01])/;
my $test = eval { timelocal 0, 0, 0, $d, $m-1, $year - 1900 };
warn $@ if $@;
die "$in is equivalent to $year-$m-$d, which is an invalid date\n" unless defined $test;
say "$in is equivalent to $year-$m-$d.";
