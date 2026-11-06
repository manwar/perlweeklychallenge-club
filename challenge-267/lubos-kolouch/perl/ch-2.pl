#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int Str);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Line Counts (The Weekly Challenge 267 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl abcdefghijklmnopqrstuvwxyz 10 10 ...
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given a string C<$str> and an array of 26 integers C<@widths>
representing the widths of characters from 'a' to 'z'.

Write a script to return the number of lines and the width of the last line
needed to display the string, given a max line width of 100.

=head1 FUNCTIONS

=head2 line_counts($str, $widths_ref)

Calculates the number of lines and the width of the last line required to display
the string using the provided character widths and a maximum line width of 100.

=over 4

=item * C<$str> - The input string consisting of lowercase letters 'a'..'z'.

=item * C<$widths_ref> - Reference to an array of 26 character widths.

=back

Returns a two-element array: C<($lines, $last_line_width)>.

=cut

signature_for line_counts => (
    method     => 0,
    positional => [ Str, ArrayRef [Int] ],
);

sub line_counts ( $str, $widths_ref ) {
    my $max_width     = 100;
    my $current_width = 0;
    my $lines         = 1;

    for my $char ( split //, $str ) {
        my $char_width = $widths_ref->[ ord($char) - ord('a') ];
        if ( $current_width + $char_width > $max_width ) {
            $lines++;
            $current_width = $char_width;
        }
        else {
            $current_width += $char_width;
        }
    }

    return ( $lines, $current_width );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $str    = shift @args;
    my @widths = map { int($_) } @args;
    my ( $lines, $width ) = line_counts( $str, \@widths );
    say "Output: ($lines, $width)";
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            str      => 'abcdefghijklmnopqrstuvwxyz',
            widths   => [ (10) x 26 ],
            expected => [ 3, 60 ],
        },
        {
            label    => 'Example 2',
            str      => 'bbbcccdddaaa',
            widths   => [ 4, 10, (10) x 24 ],
            expected => [ 2, 4 ],
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        my @res = line_counts( $case->{str}, $case->{widths} );
        is_deeply( \@res, $case->{expected}, $case->{label} );
    }
    done_testing();
}

_run_cli(@ARGV);

=cut
