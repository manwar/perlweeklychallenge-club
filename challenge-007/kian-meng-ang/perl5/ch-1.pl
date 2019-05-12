#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;
use utf8;

sub generate_niven_sequence {
    my %args = @_;

    $args{from} //= 0;
    $args{to} //= 50;

    my @niven_numbers;
    foreach my $number ($args{from}..$args{to}) {
        next if ($number == 0);

        my $sum_of_its_digits = 0;
        $sum_of_its_digits += $_ foreach split //, $number;
        push @niven_numbers, $number if ($number % $sum_of_its_digits == 0);
    }

    return \@niven_numbers;
}

say join q/|/, @{generate_niven_sequence(from => 0, to =>50)};

1;

__END__
$ perl ch1-1.pl
1|2|3|4|5|6|7|8|9|10|12|18|20|21|24|27|30|36|40|42|45|48|50
# vi:et:sw=4 ts=4 ft=perl

