#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Int);

=pod

=head1 NAME

ch-2.pl - Penny Piles

=head1 SYNOPSIS

  perl ch-2.pl 5
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Count the number of ways to write n as a sum of positive integers in
non-decreasing order (integer partitions).

=cut

my $INT_CHECK = compile(Int);

sub penny_piles ($n) {
    ($n) = $INT_CHECK->($n);
    die 'Expected n > 0' if $n <= 0;

    my @dp = (0) x ( $n + 1 );
    $dp[0] = 1;
    for my $k ( 1 .. $n ) {
        for my $i ( $k .. $n ) {
            $dp[$i] += $dp[ $i - $k ];
        }
    }
    return $dp[$n];
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <n>\n" if @args != 1;
    my $n   = 0 + $args[0];
    my $out = penny_piles($n);
    say "Input:  \$n = $n";
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::plan( tests => 1 );
    Test::More::is( penny_piles(5), 7, 'Example' );
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 penny_piles($n)

Returns the number of integer partitions of C<$n>.

=cut

