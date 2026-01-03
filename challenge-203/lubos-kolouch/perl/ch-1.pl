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

ch-1.pl - Special Quadruplets

=head1 SYNOPSIS

  perl ch-1.pl 1 2 3 6
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Count quadruplets (a, b, c, d) such that:

  nums[a] + nums[b] + nums[c] == nums[d]
  a < b < c < d

=cut

my $ARR_CHECK = compile( ArrayRef [Int] );

sub special_quadruplets ($nums) {
    ($nums) = $ARR_CHECK->($nums);
    my $n = scalar @$nums;
    return 0 if $n < 4;

    my %pair_counts;    # sums for pairs (a,b) with a<b<c, maintained per c
    my $count = 0;

    for my $c ( 2 .. $n - 2 ) {
        my $b = $c - 1;
        for my $a ( 0 .. $b - 1 ) {
            $pair_counts{ $nums->[$a] + $nums->[$b] }++;
        }

        for my $d ( $c + 1 .. $n - 1 ) {
            my $need = $nums->[$d] - $nums->[$c];
            $count += $pair_counts{$need} // 0;
        }
    }

    return $count;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @nums = map { 0 + $_ } @args;
    my $out  = special_quadruplets( \@nums );
    say 'Input:  @nums = (' . join( ', ', @nums ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', nums => [ 1, 2, 3, 6 ],     expected => 1 },
        { label => 'Example 2', nums => [ 1, 1, 1, 3, 5 ],  expected => 4 },
        { label => 'Example 3', nums => [ 3, 3, 6, 4, 5 ],  expected => 0 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( special_quadruplets( $case->{nums} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 special_quadruplets($nums)

Returns the number of special quadruplets.

=cut

