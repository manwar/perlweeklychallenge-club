#!/usr/bin/perl

use strict;
use v5.10;
use List::Util "uniqint";

my @list = @ARGV;
my $hindex;

sort { $b <=> $a } @list;

for (my $index = 0; $index <= scalar @list; $index++) {
    if ($index + 1 >= $list[$index]) {$hindex = $list[$index]; last};
}
$hindex ? say $hindex : say "This researcher has no H-Index.";