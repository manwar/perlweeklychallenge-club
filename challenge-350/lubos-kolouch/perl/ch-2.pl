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

ch-2.pl - Shuffle Pairs

=head1 SYNOPSIS

  perl ch-2.pl 1500 2500 1
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Counts integers C<i> in the inclusive range C<$from .. $to> that participate in
at least C<$count> different shuffle pairs.

Two integers A <= B form a shuffle pair when B = A * k for some integer k, and
A and B contain the same digits (in any order).

The implementation uses digit signatures (sorted digit strings) and iterates
over all relevant multipliers k >= 2 such that A*k is within the range.

=cut

my $INT_CHECK = compile(Int, Int, Int);

sub _signature ($n) {
    return join '', sort split //, "$n";
}

sub shuffle_pairs_count ($from, $to, $count) {
    ( $from, $to, $count ) = $INT_CHECK->( $from, $to, $count );
    die 'Expected $from <= $to' if $from > $to;
    die 'Expected $count >= 1' if $count < 1;

    my %witnesses;

    for my $a ( $from .. $to ) {
        my $sig_a = _signature($a);
        my $digits = length $a;
        my $max    = 10**$digits - 1;
        my $kmax   = int( $max / $a );
        next if $kmax < 2;

        for my $k ( 2 .. $kmax ) {
            my $b = $a * $k;
            next if $b < $a;    # defensive, though k>=2 ensures b>a
            next if length($b) != length($a);
            next if _signature($b) ne $sig_a;
            $witnesses{$a}{$k} = 1;
        }
    }

    my $qualified = 0;
    for my $a ( $from .. $to ) {
        my $num = $witnesses{$a} ? scalar keys %{ $witnesses{$a} } : 0;
        ++$qualified if $num >= $count;
    }
    return $qualified;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die "Usage: perl $0 <from> <to> <count>\n" if @args != 3;
    my ( $from, $to, $count ) = map { 0 + $_ } @args;
    my $out = shuffle_pairs_count( $from, $to, $count );
    say "Input: \$from = $from, \$to = $to, \$count = $count";
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', from => 1,         to => 1000,      count => 1, expected => 0 },
        { label => 'Example 2', from => 1500,      to => 2500,      count => 1, expected => 3 },
        { label => 'Example 3', from => 1_000_000, to => 1_500_000, count => 5, expected => 2 },
        { label => 'Example 4', from => 13_427_000, to => 14_100_000, count => 2, expected => 11 },
        { label => 'Example 5', from => 1030,      to => 1130,      count => 1, expected => 2 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = shuffle_pairs_count( $case->{from}, $case->{to}, $case->{count} );
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 shuffle_pairs_count($from, $to, $count)

Returns the number of integers in the range that belong to at least C<$count>
different shuffle pairs.

=cut
