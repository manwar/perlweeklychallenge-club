#!/usr/bin/env perl

use v5.40;

use Test::More;

sub do_it ($coordinates) {
    if ($coordinates eq 'a1') { return false; }
    my ($letter, $number) = $coordinates =~ /^(.)(.)\z/;
    my $parity = (ord($letter) - ord('a') + $number - 1) % 2;
    return $parity ^^ do_it('a1');
}

is do_it('d3'), true, 'Example 1';
is do_it('g5'), false, 'Example 2';
is do_it('e6'), true, 'Example 3';

done_testing();