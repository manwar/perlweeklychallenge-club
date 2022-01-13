#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       longpork.pl
#
#       Long Primes
#         Submitted by: Mohammad S Anwar
#         Write a script to generate first 5 Long Primes.
# 
#         A prime number (p) is called Long Prime if (1/p) has an infinite
#         decimal expansion repeating every (p-1) digits.
# 
#         Example
#         7 is a long prime since 1/7 = 0.142857142857...
#         The repeating part (142857) size is 6 
#         i.e. one less than the prime number 7.
# 
#         Also 17 is a long prime since 1/17 = 0.05882352941176470588235294117647...
#         The repeating part (0588235294117647) size is 16 
#         i.e. one less than the prime number 17.
# 
#         Another example, 2 is not a long prime as 1/2 = 0.5.
#         There is no repeating part in this case.


#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


say '  1/n  |  reptend value';
say '-------+---------------------------------';

for my $val (3..149) {
    next if not  long_prime( $val );
    say sprintf "%5s     %s", $val, get_reptend( $val );
}

sub long_prime ( $num ){
    my $rep = get_reptend( $num );
    return (length $rep == $num - 1)
        ? 1
        : 0 ;
}

sub get_reptend ($div) {
    ## extract the whole-number portion of the quotient in one step
    ## and start the decimal portion with the remainder
    my ($whole, $r) = ediv( 1, $div );

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
        until ($r - $div >= 0) {
            $pos++;
            $r .= 0;
            exists $seen{$r} ? last : ($seen{$r} = $pos);
            push @q, 0;  
        }

        ## the long division step
        my $q;
        ($q, $r) = ediv($r, $div);
        push @q => $q;

        $pos++;
    }

    ## OUTPUT 
    if ($r) {                    
        my $start   = $seen{$r};
        my $end     = $pos-1;
        my @rep     = @q[$start..$end];
        return join '', @rep;
    }
}

sub ediv ( $num, $den ) {   
## Euclidean division of $num by $den returns quotient and remainder
    (int( $num / $den ), $num % $den);
}


