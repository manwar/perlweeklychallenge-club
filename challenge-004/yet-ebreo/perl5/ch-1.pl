# Write a script to output the same number of PI digits as the size of your script. 
# Say, if your script size is 10, it should print 3.141592653.

use strict;
use warnings;
use 5.010;

my $size = -s $0;
use bigint;
my $n = 10 ** ($size+5) * 2;
my $p = 4 * $n;
my $i = 0;
while ($n) {
    $p += $n;
    $i += 1;
    $n *= $i;
    $n = $n /(2 * $i + 1);
}

say "File Size: $size Bytes";
say "PI ($size-digits): 3.".substr $p,2,$size-1;