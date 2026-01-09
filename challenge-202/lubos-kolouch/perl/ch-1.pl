#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-1.pl - Consecutive Odds

=head1 SYNOPSIS

  perl ch-1.pl 1 5 3 6
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Print 1 if the input array contains three consecutive odd numbers, otherwise 0.

=cut

my $ARR_CHECK = compile( ArrayRef [Int] );

sub consecutive_odds ($array) {
    ($array) = $ARR_CHECK->($array);

    my $run = 0;
    for my $x (@$array) {
        if ( $x % 2 != 0 ) {
            ++$run;
            return 1 if $run >= 3;
        }
        else {
            $run = 0;
        }
    }
    return 0;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @array = map { 0 + $_ } @args;
    my $out   = consecutive_odds( \@array );
    say 'Input:  @array = (' . join( ', ', @array ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', array => [ 1, 5, 3, 6 ], expected => 1 },
        { label => 'Example 2', array => [ 2, 6, 3, 5 ], expected => 0 },
        { label => 'Example 3', array => [ 1, 2, 3, 4 ], expected => 0 },
        { label => 'Example 4', array => [ 2, 3, 5, 7 ], expected => 1 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( consecutive_odds( $case->{array} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 consecutive_odds($array)

Returns 1 if there are 3 consecutive odds, otherwise 0.

=cut

