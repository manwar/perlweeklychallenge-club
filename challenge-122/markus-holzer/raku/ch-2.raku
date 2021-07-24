# Write a script to find out the different ways you can score $S points in basketball

multi points( $S, *@c where @c.sum == $S ) {
    take @c and nextsame;
}

multi points( $S, *@c where @c.sum <= $S ) {
    points $S, @c, $_ for 1..3 }

multi points( | ) { }

say gather points 6;