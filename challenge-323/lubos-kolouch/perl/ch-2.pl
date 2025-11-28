#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

=head1 DESCRIPTION

Tax Amount (Weekly Challenge 323)

Given an income and tax brackets [upper_limit, percent], compute total
tax owed. Brackets apply progressively.

=cut

sub tax_amount ($income, @tax_brackets) {
    my $prev = 0;
    my $total = 0;
    for my $bracket (@tax_brackets) {
        my ($upper, $percent) = @$bracket;
        last if $income <= $prev;
        my $taxable = ($income < $upper ? $income : $upper) - $prev;
        $total += $taxable * ($percent / 100);
        $prev = $upper;
    }
    return $total;
}

if (!caller) {
    require Test::More;
    Test::More::is( sprintf('%.2f', tax_amount(10, [3,50],[7,10],[12,25]) ), '2.65', 'Example 1' );
    Test::More::is( sprintf('%.2f', tax_amount(2, [1,0],[4,25],[5,50]) ), '0.25', 'Example 2' );
    Test::More::is( sprintf('%.2f', tax_amount(0, [2,50]) ), '0.00', 'Example 3' );
    Test::More::done_testing();
}
