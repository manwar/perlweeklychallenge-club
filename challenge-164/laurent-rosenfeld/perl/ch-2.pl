use strict;
use warnings;
use feature "say";

sub is_happy {
    my $n = shift;
    my %seen;
    while (1) {
        return 1 if $n == 1;
        return 0 if exists $seen{$n};
        $seen{$n} = 1;
        my $sum = 0;
        $sum += $_ for map $_ ** 2, split //, $n;
        $n = $sum;
    }
}
my $count = 0;
my $i = 1;
while ($count < 8) {
    if (is_happy $i) {
        print "$i ";
        $count++;
    }
    $i++;
}
say "";
