#!/usr/bin/env perl6
#
#
#       big-ole-p-square.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $base = 8 ) ;


my $max = (1 ~ 0 x $base).parse-base($base)
                         .sqrt
                         .Int ;
            
repeat { $max-- } while repeats-in-base( $max², $base );
    
say qq:to/END/;     
    found $max squared is {$max²}
    in base $base: {$max.base($base)} squared is {$max².base($base)}
    END
    

sub repeats-in-base ( $num, $base ) {

    return ($num.base($base)
                .comb
                .Bag 
                .values
                .sort)[*-1] > 1
        ?? 1
        !! 0 ;
}
    
