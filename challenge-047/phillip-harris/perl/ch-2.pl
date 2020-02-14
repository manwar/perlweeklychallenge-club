#!/usr/bin/perl

#Write a script to print first 20 Gapful Numbers greater than or equal to 100.

$x = 100;
while ( $gaps < 20 ) {
    if ( $x % ( substr( $x, 0, 1 ) . substr( $x, -1 ) ) == 0 ) {
        print "$x\n";
        $gaps++;
    }
    $x++;
}
