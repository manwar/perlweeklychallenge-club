#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (my $n = <>) {
    my $sf = 1;
    for (my $i = 1; $i <= $n; $i ++) {
        $sf = $i * $sf + 1 - 2 * ($i % 2)
    }
    say $sf
}


__END__
