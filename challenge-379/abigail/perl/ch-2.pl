#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

use integer;

while (my $line = <>) {
    my ($base, $limit) = split ' ' => $line;
    for (my $n = 0; $n <= $limit; $n ++) {
        my $size = 0;
        for (my $n_c = $n; $n_c; $n_c /= $base) {
            $size ++;
        }
        my $sum = 0;
        for (my $n_c = $n; $n_c; $n_c /= $base) {
            $sum += ($n_c % $base) ** $size;
        }
        print "$n " if $n == $sum;
    }
    print "\n";
}

__END__
