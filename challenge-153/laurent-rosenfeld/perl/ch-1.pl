use strict;
use warnings;
use feature "say";

my @a = (0, 1);
for my $n (2..10) {
    $a[$n] = $n * $a[$n -1] - ($n - 1) * $a[$n - 2];
}
say "@a[1..10]";
