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

ch-2.pl - Reverse Equals

=head1 SYNOPSIS

  perl ch-2.pl "3,2,1,4" "1,2,3,4"
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Returns true if the source array can be transformed into the target array by
reversing exactly one contiguous subarray. If the arrays are already equal,
reversing any length-1 subarray keeps them equal, so the answer is true.

=cut

my $ARGS_CHECK = compile( ArrayRef [Int], ArrayRef [Int] );

sub reverse_equals ($source, $target) {
    ( $source, $target ) = $ARGS_CHECK->( $source, $target );
    die 'Arrays must have the same length' if @$source != @$target;
    return 1 if !@$source;

    my $left = 0;
    ++$left while $left < @$source && $source->[$left] == $target->[$left];
    return 1 if $left == @$source;

    my $right = $#$source;
    --$right while $right >= 0 && $source->[$right] == $target->[$right];

    my @candidate = @$source;
    @candidate[ $left .. $right ] = reverse @candidate[ $left .. $right ];

    for my $i ( 0 .. $#candidate ) {
        return 0 if $candidate[$i] != $target->[$i];
    }
    return 1;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die "Usage: perl $0 <comma-separated-source> <comma-separated-target>\n" if @args != 2;
    my @source = map { 0 + $_ } split /,/, $args[0];
    my @target = map { 0 + $_ } split /,/, $args[1];
    my $out = reverse_equals( \@source, \@target ) ? 'true' : 'false';
    say 'Input: @source = (' . join( ', ', @source ) . ')';
    say '       @target = (' . join( ', ', @target ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', source => [ 3, 2, 1, 4 ], target => [ 1, 2, 3, 4 ], expected => 1 },
        { label => 'Example 2', source => [ 1, 3, 4 ],    target => [ 4, 1, 3 ],    expected => 0 },
        { label => 'Example 3', source => [2],            target => [2],            expected => 1 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = reverse_equals( $case->{source}, $case->{target} ) ? 1 : 0;
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 reverse_equals($source, $target)

Returns a boolean indicating whether reversing exactly one contiguous subarray
in C<$source> can make it match C<$target>.

=cut
