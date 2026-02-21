#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-1.pl - Show multiple arrays content

=head1 SYNOPSIS

  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given two or more arrays, display the values of each list at each index.

Example:

  Array 1: [ I L O V E Y O U ]
  Array 2: [ 2 4 0 3 2 0 1 9 ]
  Array 3: [ ! ? £ $ % ^ & * ]

Output:

  I 2 !
  L 4 ?
  ...

=cut

sub show_multiple_arrays ($arrays) {
    die "Need at least 2 arrays\n" if @$arrays < 2;
    my $len = scalar( @{ $arrays->[0] } );
    die "All arrays must have same length\n"
        if grep { scalar(@$_) != $len } @$arrays;

    my @lines;
    for my $i ( 0 .. $len - 1 ) {
        push @lines, join ' ', map { $_->[$i] } @$arrays;
    }
    return \@lines;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @a1 = qw(I L O V E Y O U);
    my @a2 = qw(2 4 0 3 2 0 1 9);
    my @a3 = ( '!', '?', '£', '$', '%', '^', '&', '*' );

    Test::More::is_deeply(
        show_multiple_arrays( [ \@a1, \@a2, \@a3 ] ),
        [ 'I 2 !', 'L 4 ?', 'O 0 £', 'V 3 $', 'E 2 %', 'Y 0 ^', 'O 1 &', 'U 9 *' ],
        'Example'
    );

    Test::More::done_testing();
}

sub _run_cli (@args) {
    if (@args) {
        die "Run without arguments to execute embedded tests.\n";
    }
    _run_tests();
}

_run_cli(@ARGV);

