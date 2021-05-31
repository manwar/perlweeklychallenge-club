#!/usr/bin/env perl6
#
#
#       your-next-pal.raku
#
#         next palindrome number
#         submitted by: mohammad s anwar
#         you are given a positive integer $n.
# 
#         write a script to find out the next palindrome number higher than the
#         given integer $n.
# 
#             example
#             
#             input: $n = 1234
#             output: 1331
# 
#             input: $n = 999
#             output: 1001
#
# 
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ($num = 20001) ;

say next-p( $num );

sub next-p ($n) {
    my $half = $n.substr( 0, ceiling($n.chars/2) );
    $n.substr( *-floor($n.chars/2) ) > $half.substr(0, floor($n.chars/2)).flip
        && $half++;
    $half ~ $half.substr(0, floor($n.chars/2)).flip;
}


