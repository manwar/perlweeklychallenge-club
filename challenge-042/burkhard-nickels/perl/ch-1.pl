#!/usr/bin/perl

use strict;
use warnings;

print "ch-1.pl (Version 1.0) PWC #42 Task #1: Octal Numbers\n";

# Version 1: foreach loop with printf
foreach (0 .. 50) { 
	printf("Decimal: %d - Octal: %o\n",$_,$_); 
}

# Version 2: map with sprintf
print my @res = map { sprintf("Dec %d - Oct %o\n",$_,$_) } (0 .. 50);

