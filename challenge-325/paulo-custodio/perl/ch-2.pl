#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 prices...\n";
say "(", join(", ", final_prices(@ARGV)), ")";

sub final_prices {
    my(@prices) = @_;

    my $find_le_price = sub {
        my($price, @next) = @_;
        return 0 if @next==0;
        for my $i (0 .. $#next) {
            if ($next[$i] <= $price) {
                return $next[$i];
            }
        }
        return 0;
    };

    my @final;
    for my $i (0 .. $#prices) {
        my $lower = $find_le_price->(@prices[$i .. $#prices]);
        push @final, $prices[$i] - $lower;
    }
    return @final;
}
