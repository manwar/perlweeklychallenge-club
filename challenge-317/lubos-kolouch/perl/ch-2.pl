use strict;
use warnings;
use Test::More;

sub is_friendly_string {
    my ( $str1, $str2 ) = @_;

    # Input validation
    return 0 if !$str1 || !$str2 || length($str1) != length($str2);

    # If strings are identical, return true
    return 1 if $str1 eq $str2;

    # Find positions where strings differ
    my @diff_positions;
    for my $i ( 0 .. length($str1) - 1 ) {
        push @diff_positions, [ $i, substr( $str1, $i, 1 ), substr( $str2, $i, 1 ) ]
          if substr( $str1, $i, 1 ) ne substr( $str2, $i, 1 );
    }

    # If exactly two positions differ, check if swapping them works
    if ( @diff_positions == 2 ) {
        my ( $pos1, $char1, $char2 ) = @{ $diff_positions[0] };
        my ( $pos2, $char3, $char4 ) = @{ $diff_positions[1] };
        return 1 if $char1 eq $char4 && $char2 eq $char3;
    }

    return 0;
}

# Unit Tests
subtest 'Friendly Strings Tests' => sub {
    is( is_friendly_string( "desc",   "dsec" ),    1, 'Example 1' );
    is( is_friendly_string( "fuck",   "fcuk" ),    1, 'Example 2' );
    is( is_friendly_string( "poo",    "eop" ),     0, 'Example 3' );
    is( is_friendly_string( "stripe", "sprite" ),  1, 'Example 4' );
    is( is_friendly_string( "",       "test" ),    0, 'Empty first string' );
    is( is_friendly_string( "test",   "" ),        0, 'Empty second string' );
    is( is_friendly_string( "test",   "testing" ), 0, 'Different lengths' );
    is( is_friendly_string( "hello",  "hello" ),   1, 'Identical strings' );
};

done_testing();
