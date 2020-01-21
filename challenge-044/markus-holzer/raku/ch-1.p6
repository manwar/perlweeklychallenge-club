.say for ( gather candidates( "123456789" ) ).grep: *.sum == 100;

sub candidates( $str )
{
    for 1..^($str.chars) -> $l
    {
        my $i = $str.substr( 0, $l ).Int;

        for -1, 1 -> $f
        {
            my $j = $str.substr( $l, * ).Int;

            take [ $i * $f, $j ];
            take [ $i * $f, $j * -1 ];
            take [ $i * $f, |$_ ] for gather candidates( $j.Str );
        }
    }
}

# Outputs:
#
# [-1 2 -3 4 5 6 78 9]
# [1 2 3 -4 5 6 78 9]
# [1 2 34 -5 67 -8 9]
# [1 23 -4 5 6 78 -9]
# [1 23 -4 56 7 8 9]
# [12 -3 -4 5 -6 7 89]
# [12 3 -4 5 67 8 9]
# [123 -45 -67 89]
# [12 3 4 5 -6 -7 89]
# [123 -4 -5 -6 -7 8 -9]
# [123 4 -5 67 -89]
# [123 45 -67 8 -9]
#
# I was surprised there are so many solutions