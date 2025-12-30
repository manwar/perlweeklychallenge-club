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

ch-1.pl - Good Integer

=head1 SYNOPSIS

  perl ch-1.pl 12344456
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

An integer is considered "good" if it contains exactly three consecutive
matching digits that are not part of a longer run of the same digit.

This script returns the first such 3-digit substring scanning left-to-right,
or C<-1> if no such substring exists.

=cut

my $INT_CHECK = compile(Int);

sub good_integer ($int) {
    ($int) = $INT_CHECK->($int);

    my $s = "$int";
    my $n = length $s;
    return -1 if $n < 3;

    for my $i ( 0 .. $n - 3 ) {
        my $d = substr( $s, $i, 1 );
        next if substr( $s, $i + 1, 1 ) ne $d;
        next if substr( $s, $i + 2, 1 ) ne $d;

        my $prev_ok = $i == 0 || substr( $s, $i - 1, 1 ) ne $d;
        my $next_ok = ( $i + 3 ) >= $n || substr( $s, $i + 3, 1 ) ne $d;
        return $d x 3 if $prev_ok && $next_ok;
    }

    return -1;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <int>\n" if @args != 1;
    my $int = 0 + $args[0];
    my $out = good_integer($int);
    say "Input:  \$int = $int";
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', int => 12344456, expected => '444' },
        { label => 'Example 2', int => 1233334,  expected => -1 },
        { label => 'Example 3', int => 10020003, expected => '000' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( good_integer( $case->{int} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 good_integer($int)

Returns the first good 3-digit substring, or C<-1> if none exists.

=cut

