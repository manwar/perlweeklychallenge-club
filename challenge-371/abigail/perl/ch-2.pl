#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (<>) {
    my @numbers = split;
    foreach my $mask (1 .. 2 ** @numbers - 2) {
        my $sum;
        while (my ($index, $val) = each @numbers) {
            $sum += $val - $index - 1 if $mask & (1 << $index);
        }
        if ($sum == 0) {
            my @set = @numbers [grep {$mask & (1 << $_)} keys @numbers];
            print "@set; " if @set > 1;
        }
    }
    print "\n";
}

__END__
