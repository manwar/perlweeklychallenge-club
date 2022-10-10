#!/usr/bin/perl
use 5.030;
use warnings;

my @list = @ARGV;
my $seq = '00';
my @output = map { s/^../$seq++/emsx; $_; } @list;
say join q{ }, @output;