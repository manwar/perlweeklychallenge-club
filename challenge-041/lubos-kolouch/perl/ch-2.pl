#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - Leonardo Numbers

=head1 SYNOPSIS

  perl ch-2.pl        # runs the embedded tests
  perl ch-2.pl        # (same) prints first 20 numbers when tests pass

=head1 DESCRIPTION

Display the first 20 Leonardo numbers, defined by:

  L(0) = 1
  L(1) = 1
  L(n) = L(n-1) + L(n-2) + 1   for n >= 2

=cut

sub leonardo_numbers ($count) {
    die "count must be positive\n" if $count !~ /^\d+$/ || $count < 1;

    my @l = (1);
    return \@l if $count == 1;
    push @l, 1;

    for my $i ( 2 .. $count - 1 ) {
        push @l, $l[ $i - 1 ] + $l[ $i - 2 ] + 1;
    }

    return \@l;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my $l = leonardo_numbers(20);
    Test::More::is( $l->[0], 1, 'L(0)=1' );
    Test::More::is( $l->[1], 1, 'L(1)=1' );
    Test::More::is( $l->[2], 3, 'L(2)=3' );
    Test::More::is( $l->[3], 5, 'L(3)=5' );
    Test::More::is( scalar(@$l), 20, 'first 20 numbers' );

    for my $i ( 2 .. $#$l ) {
        Test::More::is( $l->[$i], $l->[ $i - 1 ] + $l->[ $i - 2 ] + 1, "recurrence at $i" );
    }

    Test::More::done_testing();
}

sub _run_cli (@args) {
    if (@args) {
        die "Run without arguments to execute embedded tests and print results.\n";
    }

    _run_tests();
    say join ', ', leonardo_numbers(20)->@*;
}

_run_cli(@ARGV);
