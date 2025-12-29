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

ch-1.pl - Largest Number

=head1 SYNOPSIS

  perl ch-1.pl 20 3
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Arrange the given positive integers to form the largest possible concatenated
number.

The comparator orders a and b by comparing (a||b) vs (b||a).

=cut

my $LIST_CHECK = compile( ArrayRef [Int] );

sub largest_number ($ints) {
    ($ints) = $LIST_CHECK->($ints);
    die 'Expected positive integers' if grep { $_ <= 0 } @$ints;

    my @sorted = sort {
        ( "$b$a" cmp "$a$b" )
            ||
          ( $b <=> $a )
    } @$ints;

    return join '', @sorted;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { 0 + $_ } @args;
    my $out  = largest_number( \@ints );
    say 'Input:  @ints = (' . join( ', ', @ints ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 20, 3 ],             expected => '320' },
        { label => 'Example 2', ints => [ 3, 30, 34, 5, 9 ],   expected => '9534330' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( largest_number( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 largest_number($ints)

Returns the largest concatenated number formed by ordering the input integers.

=cut
