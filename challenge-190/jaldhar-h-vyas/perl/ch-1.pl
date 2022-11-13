#!/usr/bin/perl
use 5.030;
use warnings;

my $s = shift // die "Need a string of upper or lower case letters!\n";

say 
     $s =~ /^ [A-Z] [a-z]* $/x ||
     $s =~ /^ [A-Z]* $/x ||
     $s =~ /^ [a-z]* $/x 
? 1 : 0;