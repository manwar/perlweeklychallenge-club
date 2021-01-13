use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my $str = shift @ARGV;
my $len = length $str;

ONE: for my $one ( 1..3 ) {
    my $octet_A = substr($str, 0, $one);
    last if $octet_A == 0 || $octet_A > 255;                           #1

    TWO: for my $two ( 1..3 ) {
        next ONE if $one+$two >= $len-1;                               #2
        my $octet_B = substr($str, $one, $two);
        next ONE if $octet_B == 0 || $octet_B > 255;                   #1

        THREE: for my $three ( 1..3 ) {
            next TWO if $one+$two+$three >= $len;                      #2
            my $octet_C = substr($str, $one+$two, $three);
            next TWO if $octet_C == 0 || $octet_C > 255;               #1

            FOUR: for my $four ( 1..3 ) {
                next THREE if $one+$two+$three+$four > $len;           #2
                next if $one+$two+$three+$four < $len;                 #3
                my $octet_D = substr($str, $one+$two+$three, $four);
                next THREE if $octet_D == 0 || $octet_D > 255;         #1

                say "$octet_A.$octet_B.$octet_C.$octet_D";             ## success!
                next THREE;
            }
        }
    }
}
