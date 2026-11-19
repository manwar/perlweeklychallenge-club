#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params    -sigs;
use Types::Standard qw(Int);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Unique Sum Zero (PWC 252 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl 5
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an integer, C<$n>.
Write a script to find an array containing C<$n> unique integers such that they add up to zero.

=cut

my $check_n = signature( positional => [Int] );

sub unique_sum_zero ($n) {
    ($n) = $check_n->($n);
    die "n must be non-negative\n" if $n < 0;

    my @result = map { $_, -$_ } ( 1 .. int( $n / 2 ) );
    push @result, 0 if $n % 2 != 0;
    return \@result;
}

sub _sum ($arr) {
    my $total = 0;
    $total += $_ for @{$arr};
    return $total;
}

sub _all_unique ($arr) {
    my %seen;
    for my $x ( @{$arr} ) {
        return 0 if $seen{$x}++;
    }
    return 1;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $n   = int( $args[0] );
    my $res = unique_sum_zero($n);
    say 'Output: (' . join( ', ', @{$res} ) . ')';
    return;
}

sub _run_tests () {
    my @cases = ( 5, 3, 1, 4, 2 );

    plan tests => 3 * scalar @cases;
    for my $n (@cases) {
        my $res = unique_sum_zero($n);
        is( scalar @{$res},   $n, "n=$n: length is $n" );
        ok( _all_unique($res), "n=$n: all elements unique" );
        is( _sum($res), 0, "n=$n: sum is 0" );
    }
    return;
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 unique_sum_zero($n)

Returns an arrayref of C<$n> unique integers whose sum is zero.

=cut
