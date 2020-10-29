#!/usr/local/bin/perl

use warnings;
use strict;

chomp(my $number = <STDIN>);

$number =~ s/\A0+//g;

print "$number\n";
