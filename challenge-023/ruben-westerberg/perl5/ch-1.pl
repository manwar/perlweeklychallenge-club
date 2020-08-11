#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw<reduce>;
use Getopt::Long;
use v5.26;
my $order=1;

GetOptions("order=i" => \$order);
my @values=@ARGV?@ARGV:(5, 9, 2, 8, 1, 6);

for (0..$order-1) {
	@values=map( { reduce {$a-$b} @values[$_, $_-1];} 1..@values-1);
}
print join " ", @values;
