#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures state);
no warnings qw(experimental::signatures);
use Type::Params    qw(compile);
use Types::Standard qw(Int StrMatch);
use Test::More;

=pod

=head1 PURPOSE

Generate all expressions that insert the binary operators C<+>, C<->, and
C<*> between the digits of a string so that the resulting arithmetic equals
a target integer.

=head1 ALGORITHM

Input validation employs L<Type::Params> ensuring a digit-only string and an
integer target. The search performs depth-first backtracking over every
possible digit partition. For each partition we append the next operand with
each operator, tracking both the cumulative value and the most recent
operand to preserve multiplication precedence:

=over 4

=item *
Addition and subtraction directly adjust the running total.

=item *
Multiplication rewinds the previous operand from the total and replaces it
with the product, effectively emulating standard precedence without parsing.

=back

Numbers containing leading zeros are skipped (except the single digit zero).
All matching expressions are sorted lexicographically before being returned.

=cut

## no critic (Subroutines::ProhibitSubroutinePrototypes)
sub magic_expression ( $digits_input, $target_input ) {
    state $check = compile( StrMatch [qr/\A\d+\z/], Int );
    my ( $digits, $target ) = $check->( $digits_input, $target_input );

    my $length = length $digits;
    my @results;

    my $search;
    $search = sub ( $pos, $expression, $value, $last_operand ) {
        if ( $pos == $length ) {
            push @results, $expression if $value == $target;
            return;
        }

        for my $end ( $pos + 1 .. $length ) {
            my $chunk = substr $digits, $pos, $end - $pos;
            next if length($chunk) > 1 && substr( $chunk, 0, 1 ) eq '0';
            my $number = 0 + $chunk;

            if ( $pos == 0 ) {
                $search->( $end, $chunk, $number, $number );
                next;
            }

            $search->( $end, "$expression+$chunk", $value + $number, $number );
            $search->( $end, "$expression-$chunk", $value - $number, -$number );

            my $product = $last_operand * $number;
            $search->( $end, "$expression*$chunk", $value - $last_operand + $product, $product );
        }
    };

    $search->( 0, q{}, 0, 0 );
    @results = sort @results;

    return \@results;
}

# Example tests provided by the specification.
is_deeply( magic_expression( '123',  6 ),  [ '1*2*3',   '1+2+3' ],   'Example 1' );
is_deeply( magic_expression( '105',  5 ),  [ '1*0+5',   '10-5' ],    'Example 2' );
is_deeply( magic_expression( '232',  8 ),  [ '2*3+2',   '2+3*2' ],   'Example 3' );
is_deeply( magic_expression( '1234', 10 ), [ '1*2*3+4', '1+2+3+4' ], 'Example 4' );
is_deeply(
    magic_expression( '1001', 2 ),
    [ '1+0*0+1', '1+0+0+1', '1+0-0+1', '1-0*0+1', '1-0+0+1', '1-0-0+1' ],
    'Example 5'
);

done_testing();
