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

ch-2.pl - Binary Prefix

=head1 SYNOPSIS

  perl ch-2.pl 0 1 1 0 0 1 0 1 1 1
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

For each prefix of a binary digit array, determine whether the corresponding
binary value is divisible by C<5>.

Instead of converting every prefix to a potentially huge integer, the solution
keeps only the remainder modulo 5:

  r_{i} = (r_{i-1} * 2 + bit_i) mod 5

=cut

my $NUMS_CHECK = compile( ArrayRef [Int] );

sub binary_prefix_div_by_5 ($nums) {
    ($nums) = $NUMS_CHECK->($nums);
    die 'Expected only 0/1 values' if grep { $_ != 0 && $_ != 1 } @$nums;

    my $remainder = 0;
    my @answer;

    for my $bit (@$nums) {
        $remainder = ( $remainder * 2 + $bit ) % 5;
        push @answer, ( $remainder == 0 ? 1 : 0 );
    }

    return \@answer;
}

sub _as_bool_words ($bits) {
    return [ map { $_ ? 'true' : 'false' } @$bits ];
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    my @nums = map { 0 + $_ } @args;
    my $answer = binary_prefix_div_by_5( \@nums );
    say 'Input:  @nums = (' . join( ',', @nums ) . ')';
    say 'Output: (' . join( ', ', @{ _as_bool_words($answer) } ) . ')';
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label    => 'Example 1',
            nums     => [ 0, 1, 1, 0, 0, 1, 0, 1, 1, 1 ],
            expected => [ 1, 0, 0, 0, 0, 1, 1, 0, 0, 0 ],
        },
        {
            label    => 'Example 2',
            nums     => [ 1, 0, 1, 0, 1, 0 ],
            expected => [ 0, 0, 1, 1, 0, 0 ],
        },
        {
            label    => 'Example 3',
            nums     => [ 0, 0, 1, 0, 1 ],
            expected => [ 1, 1, 0, 0, 1 ],
        },
        {
            label    => 'Example 4',
            nums     => [ 1, 1, 1, 1, 1 ],
            expected => [ 0, 0, 0, 1, 0 ],
        },
        {
            label    => 'Example 5',
            nums     => [ 1, 0, 1, 1, 0, 1, 0, 0, 1, 1 ],
            expected => [ 0, 0, 1, 0, 0, 1, 1, 1, 0, 0 ],
        },
    );

    Test::More::plan( tests => scalar @cases );

    for my $case (@cases) {
        my $got = binary_prefix_div_by_5( $case->{nums} );
        Test::More::is_deeply( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 binary_prefix_div_by_5($nums)

Accepts an array reference of bits (0/1) and returns an array reference of
booleans (1/0) indicating whether each prefix is divisible by 5.

=cut
