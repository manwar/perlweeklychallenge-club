#!/usr/bin/env perl
use strict;
use warnings;


print "List elements: ";
my @list = split /\s+/, <STDIN>;
print "Three integers: ";
my @integers = split /\s+/, <STDIN>;

die 'input not valid'
    if scalar @list < 3
       or
       scalar @integers < 3
       or
       (scalar map { $_ =~ /^[+\-]?\d+$/ ? 1 : () } @list) != (scalar @list)
       or
       scalar map { $_ =~ /^[+\-]?\d+$/ } @integers != 3
;

my ($x, $y, $z) = @integers;
my $output = 0;
foreach my $i (0..$#list-2) {
    foreach my $j ($i+1..$#list-1) {
        $output += scalar map { 1 }
                          grep {
                            abs($list[$i] - $list[$j]) <= $x
                            and
                            abs($list[$j] - $list[$_]) <= $y
                            and
                            abs($list[$i] - $list[$_]) <= $z
                          } ($j+1..$#list);
    }
}
printf 'Output: %s', $output;
