use strict;
use warnings;
use Test::More;

sub alien_sort {
    my ( $words, $alien ) = @_;
    my %order;
    @order{@$alien} = 0 .. $#$alien;    # Create priority hash

    return [
        sort {
            my $len_a = length $a;
            my $len_b = length $b;

            # Compare character by character
            for ( my $i = 0 ; $i < $len_a && $i < $len_b ; $i++ ) {
                my $ca = substr( $a, $i, 1 );
                my $cb = substr( $b, $i, 1 );

                if ( $ca ne $cb ) {
                    return $order{$ca} <=> $order{$cb};
                }
            }

            # If all compared characters match, shorter word comes first
            return $len_a <=> $len_b;
        } @$words
    ];
}

# Test cases
subtest 'Example 1' => sub {
    my @words    = ( "perl", "python", "raku" );
    my @alien    = qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/;
    my $expected = [ "raku", "python", "perl" ];
    my $result   = alien_sort( \@words, \@alien );
    is_deeply( $result, $expected, 'Example 1 passed' );
};

subtest 'Example 2' => sub {
    my @words    = ( "the", "weekly", "challenge" );
    my @alien    = qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/;
    my $expected = [ "challenge", "the", "weekly" ];
    my $result   = alien_sort( \@words, \@alien );
    is_deeply( $result, $expected, 'Example 2 passed' );
};

subtest 'Same prefix' => sub {
    my @words    = ( "apple", "apples" );
    my @alien    = ( 'a' .. 'z' );
    my $expected = [ "apple", "apples" ];
    my $result   = alien_sort( \@words, \@alien );
    is_deeply( $result, $expected, 'Normal alphabet order' );

    @alien  = reverse( 'a' .. 'z' );
    $result = alien_sort( \@words, \@alien );
    is_deeply( $result, $expected, 'Reversed alphabet order' );
};

subtest 'Edge Cases' => sub {

    # Empty input
    is_deeply( alien_sort( [], [] ), [], 'Empty word list handled' );

    # Single word
    is_deeply( alien_sort( ["singular"], [ 'z', 'y', 'x' ] ), ["singular"], 'Single word unchanged' );
};

done_testing();
