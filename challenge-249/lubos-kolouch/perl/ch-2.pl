#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Str);
use Test::More;

=head1 NAME

ch-2.pl - DI String Match

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 249, Task 2: DI String Match.
Given a string C<$str> consisting of C<'I'> and C<'D'>, constructs a
permutation of C<[0 .. length($str)]> such that C<perm[i] E<lt> perm[i + 1]>
when C<$str[i] eq 'I'> and C<perm[i] E<gt> perm[i + 1]> when C<$str[i] eq 'D'>.

=head1 FUNCTIONS

=head2 di_string_match($str)

Takes a string C<$str> of C<'I'> and C<'D'> characters and returns an array
reference containing a valid permutation of C<0 .. length($str)>.

=cut

signature_for di_string_match => (
    method     => 0,
    positional => [Str],
);

sub di_string_match ($str) {
    my $n = length($str);
    my ( $low, $high ) = ( 0, $n );
    my @perm;

    for my $char ( split //, $str ) {
        if ( $char eq 'I' ) {
            push @perm, $low++;
        }
        elsif ( $char eq 'D' ) {
            push @perm, $high--;
        }
        else {
            die "Invalid character '$char': expected 'I' or 'D'\n";
        }
    }

    push @perm, $low;
    return \@perm;
}

is_deeply( di_string_match('IDID'), [ 0, 4, 1, 3, 2 ], 'Example 1' );
is_deeply( di_string_match('III'),  [ 0, 1, 2, 3 ],    'Example 2' );
is_deeply( di_string_match('DDI'),  [ 3, 2, 0, 1 ],    'Example 3' );
is_deeply( di_string_match(''),     [0],               'Empty string' );
done_testing();
