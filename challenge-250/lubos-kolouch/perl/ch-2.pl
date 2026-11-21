#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Str);
use Test::More;

=head1 NAME

ch-2.pl - Alphanumeric String Value

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 250, Task 2: Alphanumeric String Value.
Given an array of alphanumeric strings, returns the maximum value among them,
where a digits-only string evaluates to its base-10 integer value and any
other string evaluates to its length.

=head1 FUNCTIONS

=head2 max_alphanum_value($array)

Returns the maximum alphanumeric string value for the strings in the array
reference C<$array>.

=cut

signature_for max_alphanum_value => (
    method     => 0,
    positional => [ ArrayRef [Str] ],
);

sub max_alphanum_value ($array) {
    my $max_value = 0;

    for my $s ( @{$array} ) {
        my $value = ( $s =~ m/\A\d+\z/msx ? int($s) : length($s) );
        $max_value = $value if $value > $max_value;
    }

    return $max_value;
}

is( max_alphanum_value( [ 'perl', '2', '000', 'python', 'r4ku' ] ), 6,   'Test Example 1' );
is( max_alphanum_value( [ '001', '1', '000', '0001' ] ),          1,   'Test Example 2' );
is( max_alphanum_value( [] ),                                     0,   'Test Empty Array' );
is( max_alphanum_value( [ '123', '456', '789' ] ),                789, 'Test All Digits' );
is( max_alphanum_value( [ 'abc', 'def', 'ghi' ] ),                3,   'Test All Letters' );
done_testing();
