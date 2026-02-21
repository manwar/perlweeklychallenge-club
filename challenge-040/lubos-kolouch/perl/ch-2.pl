#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - Sort SubList

=head1 SYNOPSIS

  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a list of numbers and a set of indices into that list, sort the values at
those indices and write them back to the same indices.

Example:

  List:    [ 10, 4, 1, 8, 12, 3 ]
  Indices: 0,2,5

We sort values at indices 0,2,5 => 10,1,3 into 1,3,10, resulting in:

  [ 1, 4, 3, 8, 12, 10 ]

=cut

sub sort_sublist ( $list, $indices ) {
    my @out = @$list;
    my @idx = @$indices;

    my @vals = map { $out[$_] } @idx;
    @vals = sort { $a <=> $b } @vals;

    for my $i ( 0 .. $#idx ) {
        $out[ $idx[$i] ] = $vals[$i];
    }

    return \@out;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @list = ( 10, 4, 1, 8, 12, 3 );
    my @idx  = ( 0, 2, 5 );
    Test::More::is_deeply( sort_sublist( \@list, \@idx ), [ 1, 4, 3, 8, 12, 10 ], 'Example' );

    Test::More::done_testing();
}

sub _run_cli (@args) {
    if (@args) {
        die "Run without arguments to execute embedded tests.\n";
    }
    _run_tests();
}

_run_cli(@ARGV);

