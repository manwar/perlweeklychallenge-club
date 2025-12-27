#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use List::Util      qw(min);
use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-2.pl - Minimum Common

=head1 SYNOPSIS

  perl ch-2.pl "1,2,3,4" "3,4,5,6"
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Returns the minimum integer common to both arrays. If there is no common
integer, returns C<-1>.

=cut

my $LIST_CHECK = compile( ArrayRef [Int], ArrayRef [Int] );

sub minimum_common ($a, $b) {
    ( $a, $b ) = $LIST_CHECK->( $a, $b );
    my %in_b = map { $_ => 1 } @$b;
    my @common = grep { $in_b{$_} } @$a;
    return -1 if !@common;
    return min(@common);
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die "Usage: perl $0 <comma-separated-array1> <comma-separated-array2>\n" if @args != 2;
    my @a = map { 0 + $_ } split /,/, $args[0];
    my @b = map { 0 + $_ } split /,/, $args[1];
    my $out = minimum_common( \@a, \@b );
    say 'Input: @array_1 = (' . join( ', ', @a ) . ')';
    say '       @array_2 = (' . join( ', ', @b ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', a => [ 1, 2, 3, 4 ], b => [ 3, 4, 5, 6 ], expected => 3 },
        { label => 'Example 2', a => [ 1, 2, 3 ],    b => [ 2, 4 ],       expected => 2 },
        { label => 'Example 3', a => [ 1, 2, 3, 4 ], b => [ 5, 6, 7, 8 ], expected => -1 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( minimum_common( $case->{a}, $case->{b} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 minimum_common($a, $b)

Accepts two array references of integers and returns the smallest common value,
or C<-1> if none exists.

=cut
