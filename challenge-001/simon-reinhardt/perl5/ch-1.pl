#!/usr/bin/env perl
#use 5.020;
use warnings;
use strict;

my $string = "Perl Weekly Challenge";

my $count = $string =~ s/e/E/g;

#say $string;
#say $count;


print $string,"\n";
print $count,"\n";
