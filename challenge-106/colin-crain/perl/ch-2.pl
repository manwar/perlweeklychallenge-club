#! /opt/local/bin/perl
#
#       reptend.pl
#
#       TASK #2 › Decimal String
#         Submitted by: Mohammad S Anwar
#         You are given numerator and denominator i.e. $N and $D.
# 
#         Write a script to convert the fraction into decimal string. If the fractional part is recurring then put it in parenthesis.
# 
#         Example
#         Input: $N = 1, $D = 3
#         Output: "0.(3)"
# 
#         Input: $N = 1, $D = 2
#         Output: "0.5"
# 
#         Input: $N = 5, $D = 66
#         Output: "0.0(75)"
# 
#       method:
#             break down standard long-division algorithm into successive steps
#             of Euclidean Division
#             (https://en.wikipedia.org/wiki/Euclidean_division) until adding
#             additional 0s causes the new incremental digits of the quotient to
#             repeat.
# 
#             When evaluating each index position for the quotient in the
#             division, check the remainder being evaluated against a lookup hash
#             of previously seen remainders. If it is found we are repeating and
#             the current position and the position saved in the lookup
#             determine the start and end indices of the repeating segment. If a
#             lookup fails, add the remainder at that moment and the current
#             position to the lookup.
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;   
use feature ":5.26";
use feature qw(signatures);             
no warnings 'experimental::signatures';

sub get_decimal_string ($num, $den) {
    ## fraction is numerator over denominator
    ## division is dividend over divisor yielding integer quotient and remainder
    ## we'll keep to num and den as they make better variable names

    ## extract the whole-number portion of the quotient in one step
    ## and start the decimal portion with the remainder
    my ($whole, $r) = ediv( $num, $den );

    my $pos = 0;
    my %seen;
    my @q;

    while ($r != 0) {

        ## add one 0 to remainder
        ## add remainder at every index position to %seen hash
        $r .= 0;
        exists $seen{$r} ? last : ($seen{$r} = $pos);
        
        ## add additional 0s to remainder and quotient until num > den
        ## with each 0 increment index position and add to seen hash
        until ($r - $den >= 0) {
            $pos++;
            $r .= 0;
            exists $seen{$r} ? last : ($seen{$r} = $pos);
            push @q, 0;  
        }

        ## the long division step
        my $q;
        ($q, $r) = ediv($r, $den);
        push @q => $q;

        $pos++;
    }

    my $out;

    ## OUTPUT 
    ## three cases:
    ## * whole number, no decimal
    ## * isolate and present repeating fraction in parens
    ## * finishes neatly, join with decimal point
    if (@q == 0) {                  
        $out = $whole;
    }
    elsif ($r) {                    
        my $start   = $seen{$r};
        my $end     = $pos-1;
        my @pre     = @q[0..$start-1];
        my @rep     = @q[$start..$end];
        $out = join '', $whole, '.', @pre, '(', @rep, ')';
    }
    else {                         
        $out = join '', ($whole, '.', @q);
    }
}

sub ediv ( $num, $den ) {   
## Euclidean division of $num by $den returns quotient and remainder
    (int( $num / $den ), $num % $den);
}



use Test::More;
is get_decimal_string(2,1), "2",          				'2/1';
is get_decimal_string(2,2), "1",          				'2/2';

is get_decimal_string(1,2), "0.5",          				'1/2';
is get_decimal_string(1,3), "0.(3)",        				'1/3';
is get_decimal_string(1,4), "0.25",         				'1/4';
is get_decimal_string(1,5), "0.2",          				'1/5';
is get_decimal_string(1,6), "0.1(6)",       				'1/6';
is get_decimal_string(1,7), "0.(142857)",   				'1/7';
is get_decimal_string(1,8), "0.125",        				'1/8';
is get_decimal_string(1,9), "0.(1)",        				'1/9';

is get_decimal_string(1,10), "0.1",         				'1/10';
is get_decimal_string(1,11), "0.(09)",      				'1/11';
is get_decimal_string(1,12), "0.08(3)",     				'1/12';
is get_decimal_string(1,13), "0.(076923)",  				'1/13';
is get_decimal_string(1,14), "0.0(714285)",                 '1/14';
is get_decimal_string(1,15), "0.0(6)",                      '1/15';
is get_decimal_string(1,16), "0.0625",                      '1/16';
is get_decimal_string(1,17), "0.(0588235294117647)",        '1/17';
is get_decimal_string(1,18), "0.0(5)",                      '1/18';
is get_decimal_string(1,19), "0.(052631578947368421)",      '1/19';
is get_decimal_string(1,20), "0.05",                        '1/20';
is get_decimal_string(1,21), "0.(047619)",                  '1/21';
is get_decimal_string(1,22), "0.0(45)",                     '1/22';
is get_decimal_string(1,23), "0.(0434782608695652173913)",  '1/23';
is get_decimal_string(1,24), "0.041(6)",                    '1/24';
is get_decimal_string(1,25), "0.04",                        '1/25';

is get_decimal_string(1,100), "0.01",                                   '1/100';
is get_decimal_string(1,101), "0.(0099)",                               '1/101';
is get_decimal_string(1,102), "0.0(0980392156862745)",                  '1/102';
is get_decimal_string(1,103), "0.(0097087378640776699029126213592233)", '1/103';


done_testing();
