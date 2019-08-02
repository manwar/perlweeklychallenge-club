use strict;
use warnings;
use feature qw/say/;

for my $num(1..50) {
    my $sum = 0;
    for (split //, $num) {
        $sum += $_;
    }
    say $num if $num % $sum == 0;
}
