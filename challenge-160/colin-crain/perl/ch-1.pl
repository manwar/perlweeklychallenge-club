#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       .pl
#
#       Four Is Magic
#         Submitted by: Mohammad S Anwar
#         You are given a positive number, $n < 10.
# 
#         Write a script to generate english text sequence starting with
#         the English cardinal representation of the given number, the word
#         ‘is’ and then the English cardinal representation of the count of
#         characters that made up the first word, followed by a comma.
#         Continue until you reach four.
# 
# 
#         Example 1:
#             Input: $n = 5
#             Output: Five is four, four is magic.
#     
#         Example 2:
#             Input: $n = 7
#             Output: Seven is five, five is four, four is magic.
#     
#         Example 3:
#             Input: $n = 6
#             Output: Six is three, three is five, five is four, four is magic.
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use Lingua::EN::Numbers qw( num2en );

my $input = shift // -1642.669;
say magic( $input );

sub magic ($num, $out = '') {
    {
        my $name =  num2en($num);
        $out .= "$name is ";
        $name =~ s/[^a-z]//g;
        $num == 4
            ? return ($out . "magic")
            : ($out .= num2en(  length $name  ) . ', ');
        $num = length $name ;
        redo;
    }
}

sub magicX ($num) {
    my $out;

    while (1) {
        $out .= num2en($num) . " is ";
        $out .= "magic" and return $out if $num == 4 ;
        $out .= num2en(  length num2en( $num )  ) . ', ';
        $num = length num2en( $num ) ;
    }
}
