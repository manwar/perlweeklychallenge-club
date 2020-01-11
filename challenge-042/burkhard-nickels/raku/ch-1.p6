#!/home/chuck/rakudo/bin/perl6

use strict;

print "ch-1.p6 (Version 1.0) PWC #42 Task #1: Octal Numbers\n";

# Version 1: foreach loop with printf
for (0 .. 50) { 
	printf("Decimal: %d - Octal: %o\n",$_,$_); 
}

# Version 2: map with sprintf
print my @res = map { sprintf("Dec %d - Oct %o\n",$_,$_) }, (0 .. 50);

