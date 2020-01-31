use strict;
use warnings;
use feature "say";

for my $expr (glob join "{+,-,}", 1..9) {
    say $expr if eval $expr == 100;
}
