#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ shuffle };

sub _create_array {
    my ($size) = @_;
    die "Can't have more than 50 unique elements" if $size > 50;
    return ( shuffle(1 .. 50) )[0 .. $size - 1]
}

sub peak_element {
    my @array = @_;
    return @array if @array < 2;

    my @peak;
    push @peak, $array[0] if $array[1] < $array[0];
    for my $i (1 .. $#array - 1) {
        push @peak, $array[$i] if $array[$i - 1] < $array[$i]
                               && $array[$i + 1] < $array[$i];
    }
    push @peak, $array[-1] if $array[-2] < $array[-1];
    return @peak
}

sub task {
    my ($size) = @_;
    peak_element(_create_array($size))
}

use Test::More;
use Test::Deep;

my $size_ok = eval {
    _create_array(51);
1 };
my $err = $size_ok ? "" : $@;
ok ! $size_ok, 'too large';
like $err, qr/Can't have more than 50 unique elements/, 'exception';

my @random = _create_array(50);
is scalar @random, 50, 'size';
my %freq;
@freq{@random} = ();
is scalar keys %freq, 50, 'unique';

cmp_deeply [peak_element()], [], 'empty array';
cmp_deeply [peak_element(42)], [42], 'single element';
cmp_deeply [peak_element(12, 42)], [42], 'two elements, peak right';
cmp_deeply [peak_element(42, 12)], [42], 'two elements, peak left';

cmp_deeply [peak_element(18, 45, 38, 25, 10, 7, 21, 6, 28, 48)],
    bag(48, 45, 21), 'example 1';
cmp_deeply [peak_element(47, 11, 32, 8, 1, 9, 39, 14, 36, 23)],
    bag(47, 32, 39, 36), 'example 2';

done_testing();
