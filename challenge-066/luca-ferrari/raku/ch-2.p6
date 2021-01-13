#!env raku

# You are given an integer $N.

# Write a script to check if the given number can be expressed as mn where m and n are positive integers. Otherwise print 0.
# Example 1:

# For given $N = 9, it should print 32 or 3^2.
#                      Example 2:

#                   For given $N = 45, it should print 0.

sub is-power( Int:D :$what = 100, Int:D :$base = 10 ) {
    # if power of 1 must be itself!
    return 0 if ( $what == 1 );

    # if the values are the same, the pow is 1!
    return 1 if ( $what == $base );

    # not a power!
    return Nil if ( ! ( $what %% $base ) );

    # if here, should compute the power
    my $pow-increment = $what > $base ?? 1 !! -1;
    my Int $pow = 1 * $pow-increment;
    my Int $result = $base ** $pow;
    while ( $what > $result ) {
        $pow += $pow-increment;
        $result = $base ** $pow;
    }

    return $pow if $what == $result;
    return Nil;

}


sub MAIN( Int :$N ){
    my $found = False;
    for 2 ..^ $N {
        my $power = is-power( :what( $N ), :base( $_ ) );
        "$N can be expressed as $_ pow( $power )".say && $found = True if $power;
    }

    "0".say if ! $found;

}
