#!/usr/bin/perl

use strict;
use warnings;

print "Enter the string: ";
chomp(my $str = <STDIN>);

print "Enter the character to reverse prefix until: ";
chomp(my $char = <STDIN>);

my $index = index($str, $char);

if ($index == -1 || $index == 0) {
    print "$str\n";
} else {
    my $prefix = substr($str, 0, $index + 1);
    my $reversed = reverse $prefix;
    print $reversed . substr($str, $index + 1) . "\n";
}
