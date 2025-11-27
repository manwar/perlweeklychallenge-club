#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

=head1 DESCRIPTION

Final Price (Weekly Challenge 325)

For each price, subtract the first subsequent price that is less than or
equal to it; if none, keep the price. Return the list of final prices.

=cut

sub final_price (@prices) {
    my @result;
    for my $i (0 .. $#prices) {
        my $price = $prices[$i];
        my $discount = 0;
        for my $j ($i + 1 .. $#prices) {
            if ($prices[$j] <= $price) {
                $discount = $prices[$j];
                last;
            }
        }
        push @result, $price - $discount;
    }
    return \@result;
}

if (!caller) {
    require Test::More;
    Test::More::is_deeply( final_price(8, 4, 6, 2, 3), [4, 2, 4, 2, 3], 'Example 1' );
    Test::More::is_deeply( final_price(1, 2, 3, 4, 5), [1, 2, 3, 4, 5], 'Example 2' );
    Test::More::is_deeply( final_price(7, 1, 1, 5), [6, 0, 1, 5], 'Example 3' );
    Test::More::done_testing();
}
