#!/usr/bin/env perl
use v5.38;
use warnings;
use List::Util qw(shuffle);
use Type::Params -sigs;
use Types::Standard qw(Int);
use Test::More;

=head1 NAME

ch-1.pl - 6 out of 49

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 246, Task 1: 6 out of 49.
Generates six unique random integers from the range C<1> to C<49>.

=head1 FUNCTIONS

=head2 pick_lotto_numbers($count = 6, $max = 49)

Returns C<$count> unique random integers drawn from C<1..$max>.

=cut

signature_for pick_lotto_numbers => (
    method     => 0,
    positional => [ Int, { default => 6 }, Int, { default => 49 } ],
);

sub pick_lotto_numbers ( $count, $max ) {
    my @numbers = shuffle( 1 .. $max );
    return @numbers[ 0 .. $count - 1 ];
}

my @result = sort { $a <=> $b } pick_lotto_numbers();
is( scalar @result, 6, 'Six numbers are picked' );

my %seen;
$seen{$_}++ for @result;
is( scalar keys %seen, 6, 'All six numbers are unique' );

ok( ( !grep { $_ < 1 || $_ > 49 } @result ), 'All numbers are in range 1..49' );
done_testing();
