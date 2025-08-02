#!/usr/bin/perl
use List::Util 'sum0';
my $k = pop @ARGV;
print sum0(@ARGV[grep {$k == sum0(split //, sprintf("%b", $_))} 0..$#ARGV]), "\n";
