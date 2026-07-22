#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
use List::Util qw(min);
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-2.pl - Nearest RGB

=head1 DESCRIPTION

You are given a 6-digit hex color.
Write a script to round the RGB channels to the nearest web-safe value and return the nearest RGB color.

=cut

sub nearest_rgb ($hex_color) {
    $hex_color =~ s/^#//;
    $hex_color = uc($hex_color);

    die "Invalid hex color format: $hex_color" unless $hex_color =~ /^[0-9A-F]{6}$/;

    my $r_hex = substr($hex_color, 0, 2);
    my $g_hex = substr($hex_color, 2, 2);
    my $b_hex = substr($hex_color, 4, 2);

    my $r_dec = hex($r_hex);
    my $g_dec = hex($g_hex);
    my $b_dec = hex($b_hex);

    my @web_safe = (0, 51, 102, 153, 204, 255);

    my $nearest_r = _round_to_nearest($r_dec, \@web_safe);
    my $nearest_g = _round_to_nearest($g_dec, \@web_safe);
    my $nearest_b = _round_to_nearest($b_dec, \@web_safe);

    return sprintf("#%02X%02X%02X", $nearest_r, $nearest_g, $nearest_b);
}

sub _round_to_nearest ($val, $choices) {
    my $best = $choices->[0];
    my $min_diff = abs($val - $best);

    for my $choice (@$choices) {
        my $diff = abs($val - $choice);
        if ($diff < $min_diff) {
            $min_diff = $diff;
            $best = $choice;
        }
    }
    return $best;
}

sub _run_cli (@args) {
    if (!@args) { _run_tests(); return; }
    die "Usage: perl $0\n(Run with no arguments to execute the unit tests)\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', color => '#F4B2D1', expected => '#FF99CC' },
        { label => 'Example 2', color => '#15E6E5', expected => '#00FFCC' },
        { label => 'Example 3', color => '#191A65', expected => '#003366' },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = nearest_rgb($case->{color});
        Test::More::is($got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
