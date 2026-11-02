#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (my $line = <>) {
    my ($sum, $count) = (0, 0);
    foreach my $number (grep {$_ % 6 == 0} split /\s+/ => $line) {
        $sum += $number;
        $count ++;
    }
    say $sum ? int (.5 + $sum / $count) : 0;
}

__END__
