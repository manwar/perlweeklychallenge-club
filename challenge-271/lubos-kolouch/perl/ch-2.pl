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

ch-2.pl - Sort by 1 bits

=head1 SYNOPSIS

  perl ch-2.pl 0 1 2 3 4 5 6 7 8
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Sort integers by the number of 1-bits in their binary representation. If two
integers have the same number of 1-bits, sort them by numeric value.

=cut

my $ARR_CHECK = compile( ArrayRef [Int] );

sub _popcount ($n) {
    my $b = sprintf '%b', $n;
    my $c = ( $b =~ tr/1/1/ );
    return $c;
}

sub sort_by_1_bits ($ints) {
    ($ints) = $ARR_CHECK->($ints);
    return [
        sort {
                 _popcount($a) <=> _popcount($b)
              || $a <=> $b
        } @$ints
    ];
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { 0 + $_ } @args;
    my $out  = sort_by_1_bits( \@ints );
    say 'Output: (' . join( ', ', @$out ) . ')';
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label    => 'Example 1',
            ints     => [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ],
            expected => [ 0, 1, 2, 4, 8, 3, 5, 6, 7 ],
        },
        {
            label    => 'Example 2',
            ints     => [ 1024, 512, 256, 128, 64 ],
            expected => [ 64, 128, 256, 512, 1024 ],
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is_deeply( sort_by_1_bits( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 sort_by_1_bits($ints)

Returns an arrayref of the sorted integers.

=cut

