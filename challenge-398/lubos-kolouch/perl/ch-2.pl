#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Str);
use Test::More;

=head1 NAME

ch-2.pl - String Difference

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 398, Task 2: String Difference.
Given an array of equal-length strings, computes the adjacent character
difference array for each word and returns the unique word whose difference
array differs from the rest.

=head1 FUNCTIONS

=head2 string_difference($words)

Returns the string in array reference C<$words> whose consecutive character
difference signature is unique.

=cut

signature_for string_difference => (
    method     => 0,
    positional => [ ArrayRef [Str] ],
);

sub string_difference ($words) {
    my %groups;
    for my $word ( @{$words} ) {
        my @chars = split //msx, $word;
        my $sig   = join q{,}, map { ord( $chars[ $_ + 1 ] ) - ord( $chars[$_] ) } 0 .. $#chars - 1;
        push @{ $groups{$sig} }, $word;
    }

    for my $group ( values %groups ) {
        return $group->[0] if @{$group} == 1;
    }

    return q{};
}

is( string_difference( [ 'ab',   'bc',   'cd',   'zy' ] ),   'zy',   'Example 1' );
is( string_difference( [ 'cba',  'fed',  'azy' ] ),          'azy',  'Example 2' );
is( string_difference( [ 'pop',  'ada',  'beb',  'cfc' ] ),  'pop',  'Example 3' );
is( string_difference( [ 'aaaa', 'zzzz', 'mmmm', 'aaba' ] ), 'aaba', 'Example 4' );
is( string_difference( [ 'aceg', 'bdfh', 'cegi', 'azbz' ] ), 'azbz', 'Example 5' );
done_testing();
