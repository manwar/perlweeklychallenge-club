#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-1.pl - Digital Root

=head1 SYNOPSIS

  perl ch-1.pl          # runs the embedded tests
  perl ch-1.pl 38       # prints persistence and digital root

=head1 DESCRIPTION

Given a positive integer, compute:

- additive persistence: how many digit-sum iterations to reach a single digit
- digital root: the final single digit reached by repeated digit sums

=cut

sub digital_root_and_persistence ($n) {
    die "Expected positive integer\n" if $n !~ /^\d+$/ || $n < 1;

    my $persistence = 0;
    my $x           = $n;
    while ( length($x) > 1 ) {
        my $sum = 0;
        $sum += $_ for split //, $x;
        $x = $sum;
        ++$persistence;
    }
    return ( $persistence, 0 + $x );
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { int => 38,         persistence => 2, digital_root => 2, label => 'Example 1' },
        { int => 7,          persistence => 0, digital_root => 7, label => 'Example 2' },
        { int => 999,        persistence => 2, digital_root => 9, label => 'Example 3' },
        { int => 1999999999, persistence => 3, digital_root => 1, label => 'Example 4' },
        { int => 101010,     persistence => 1, digital_root => 3, label => 'Example 5' },
    );

    Test::More::plan( tests => 2 * scalar(@cases) );
    for my $t (@cases) {
        my ( $p, $dr ) = digital_root_and_persistence( $t->{int} );
        Test::More::is( $p,  $t->{persistence}, "$t->{label} (persistence)" );
        Test::More::is( $dr, $t->{digital_root}, "$t->{label} (digital root)" );
    }
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <int>\n" if @args != 1;
    my ( $p, $dr ) = digital_root_and_persistence( $args[0] );
    say "Persistence  = $p";
    say "Digital Root = $dr";
}

_run_cli(@ARGV);

