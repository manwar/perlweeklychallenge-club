#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-1.pl - Kaprekar Constant

=head1 SYNOPSIS

  perl ch-1.pl         # runs the embedded tests
  perl ch-1.pl 3524    # prints the number of iterations

=head1 DESCRIPTION

Kaprekar's constant (6174) is reached by repeatedly sorting the digits of a
4-digit number in descending and ascending order and subtracting:

  desc - asc

This script returns how many iterations are required to reach 6174.
If the sequence does not converge on 6174, it returns -1.

=cut

sub kaprekar_iterations ($n) {
    die 'Expected integer in range 0..9999' if $n !~ /^\d+$/ || $n > 9999;

    my %seen;
    my $steps = 0;

    while ( $n != 6174 ) {
        return -1 if $seen{$n}++;

        my $s = sprintf '%04d', $n;
        my @d = split //, $s;
        my $asc  = join '', sort { $a <=> $b } @d;
        my $desc = join '', sort { $b <=> $a } @d;

        $n = ( 0 + $desc ) - ( 0 + $asc );
        ++$steps;
    }

    return $steps;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { in => 3524, out => 3,  label => 'Example 1' },
        { in => 6174, out => 0,  label => 'Example 2' },
        { in => 9998, out => 5,  label => 'Example 3' },
        { in => 1001, out => 4,  label => 'Example 4' },
        { in => 9000, out => 4,  label => 'Example 5' },
        { in => 1111, out => -1, label => 'Example 6' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $t (@cases) {
        Test::More::is( kaprekar_iterations( $t->{in} ), $t->{out}, $t->{label} );
    }
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die "Usage: perl $0 <4-digit-int>\n" if @args != 1;
    say kaprekar_iterations( $args[0] );
}

_run_cli(@ARGV);

