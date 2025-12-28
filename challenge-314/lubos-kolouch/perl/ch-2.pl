#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Str);

=pod

=head1 NAME

ch-2.pl - Sort Column

=head1 SYNOPSIS

  perl ch-2.pl swpc tyad azbe
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a list of equal-length strings, count how many columns must be deleted so
that, in the remaining columns, characters in each column are sorted
lexicographically (top-to-bottom) for every column.

=cut

my $LIST_CHECK = compile( ArrayRef [Str] );

sub sort_column_deleted ($list) {
    ($list) = $LIST_CHECK->($list);
    return 0 if @$list <= 1;

    my $len = length $list->[0];
    die 'All strings must have the same length' if grep { length($_) != $len } @$list;

    my $deleted = 0;
    for my $col ( 0 .. $len - 1 ) {
        for my $row ( 1 .. $#$list ) {
            my $prev = substr( $list->[ $row - 1 ], $col, 1 );
            my $curr = substr( $list->[$row],       $col, 1 );
            if ( $prev gt $curr ) {
                ++$deleted;
                last;
            }
        }
    }

    return $deleted;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $out = sort_column_deleted( \@args );
    say 'Input:  @list = ("' . join( '", "', @args ) . '")';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', list => [qw(swpc tyad azbe)], expected => 2 },
        { label => 'Example 2', list => [qw(cba daf ghi)],    expected => 1 },
        { label => 'Example 3', list => [qw(a b c)],          expected => 0 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( sort_column_deleted( $case->{list} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 sort_column_deleted($list)

Returns the number of columns that must be removed to make all remaining
columns lexicographically sorted.

=cut
