#!/usr/bin/env perl6
#
#
#       151-1-no-diving-in-the-shallow-end.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $input = '1 | 2 3 | 4 *  * 5 | * 6' ) ;

say mindepth( parse( $input ) );

sub parse ( $input ) {
    $input  .split(/\s+/)
            .grep( * ne '|')
            .map: {$_ eq '*' ?? Nil !! $_} ;
}

sub mindepth ( @tree ) {
    my ( $level, $count ) = ( 1, 0 );
    for @tree.keys -> $idx {
        return $level if @tree[$idx].defined 
                        and not @tree[$idx * 2 + 1].defined 
                        and not @tree[$idx * 2 + 2].defined ;
                        
        $level++ and $count = 0 if ++$count == 2 ** ($level-1);
    }
}

use Test;

is mindepth( parse('1 | 2 3 | 4 5') ), 2, 'ex-1';
is mindepth( parse('1 | 2 3 | 4 *  * 5 | * 6') ), 3, 'ex-2';
is mindepth( parse('A | B C | D E  F G | H I  J L   M N  O P') ), 4, 'deeper';
is mindepth( parse('X') ), 1, 'root';

















# my $input = shift ;
# say mindepth( parse( $input ) ) if defined $input;;
# 
# sub parse ( $input ) {
#     return map { $_ eq '*' ? undef : $_ } 
#            grep { $_ ne '|' } 
#            split ' ', $input;
# }
# 
# sub mindepth ( @tree ) {
#     my $level = 1 ;
#     my $count = 0 ;
#     
#     for my $idx ( 0 .. $#tree ) {
#         return $level if ( defined $tree[$idx]  
#                             and not defined $tree[$idx * 2 + 1]
#                             and not defined $tree[$idx * 2 + 2] ) ;
#         $level++ and $count = 0 if ++$count == 2 ** ($level-1) ;    
#     }
# }
# 
