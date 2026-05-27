#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-2.pl - Find K-Beauty

=head1 DESCRIPTION

Given a number and a digit k, find the K-Beauty of the number. The K-Beauty of an
integer number is defined as the number of substrings of the given number (when
read as a string) that have a length of k and are a divisor of the given number.

=cut

sub k_beauty ($num, $k) {
    die "First argument must be an integer" unless $num =~ /^\d+$/;
    die "Second argument must be an integer" unless $k =~ /^\d+$/;

    my $str = "$num";
    my $len = length($str);
    my $count = 0;

    for my $i (0 .. $len - $k) {
        my $sub = substr($str, $i, $k);
        my $val = int($sub);
        if ($val != 0 && $num % $val == 0) {
            $count++;
        }
    }

    return $count;
}

sub _run_cli (@args) {
    if (!@args) { _run_tests(); return; }
    die "Usage: perl $0\n(Run with no arguments to execute the unit tests)\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label => 'Example 1',
            num => 240,
            k => 2,
            expected => 2
        },
        {
            label => 'Example 2',
            num => 430043,
            k => 2,
            expected => 2
        },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = k_beauty($case->{num}, $case->{k});
        Test::More::is($got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
