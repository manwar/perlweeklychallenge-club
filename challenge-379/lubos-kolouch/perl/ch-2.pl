#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-2.pl - Armstrong Number

=head1 DESCRIPTION

Find all Armstrong numbers in base $base less than $limit (with the results outputted in base 10).

=cut

sub get_digits_base ($num, $base) {
    if ($num == 0) {
        return (0);
    }
    my @digits;
    my $temp = $num;
    while ($temp > 0) {
        push @digits, $temp % $base;
        $temp = int($temp / $base);
    }
    return @digits;
}

sub is_armstrong ($num, $base) {
    my @digits = get_digits_base($num, $base);
    my $k = scalar @digits;
    my $sum = 0;
    for my $digit (@digits) {
        $sum += $digit ** $k;
    }
    return $sum == $num ? 1 : 0;
}

sub find_armstrongs ($base, $limit) {
    my @result;
    for my $i (0 .. $limit - 1) {
        if (is_armstrong($i, $base)) {
            push @result, $i;
        }
    }
    return \@result;
}

sub _run_cli (@args) {
    if (!@args) { _run_tests(); return; }
    die "Usage: perl $0\n(Run with no arguments to execute the unit tests)\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Base 3, Limit 20', base => 3, limit => 20, expected => [0, 1, 2, 5, 8, 17] },
        { label => 'Base 10, Limit 1000', base => 10, limit => 1000, expected => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407] },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = find_armstrongs($case->{base}, $case->{limit});
        Test::More::is_deeply($got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
