#!/usr/bin/env perl

# See https://en.wikipedia.org/wiki/Regular_number
# See https://en.wikipedia.org/wiki/Prime_number#Unique_factorization
# See https://en.wikipedia.org/wiki/Smooth_number

use 5.010;
use strict;
use warnings;
use utf8;

sub is_five_smooth_number {
    my $number = shift;

    die "Must be positive integer" if ($number < 1);

    return $number if ($number <= 5);

    foreach my $prime_factor (qw(2 3 5)) {
        $number = $number / $prime_factor while ($number % $prime_factor == 0);
    }
    return $number == 1;
}

my $nth_number = $ARGV[0];
die "Missing n-th smoon number" if (!$nth_number);

my ($i, @five_smooth_numbers) = (1, ());
while (scalar @five_smooth_numbers < $nth_number) {
    push @five_smooth_numbers, $i if (is_five_smooth_number($i));
    $i++;
}

say join("|", @five_smooth_numbers);


1;
# vi:et:sw=4 ts=4 ft=perl

__END__
$ perl ch1.pl 30
1|2|3|4|5|6|8|9|10|12|15|16|18|20|24|25|27|30|32|36|40|45|48|50|54|60|64|72|75|80
