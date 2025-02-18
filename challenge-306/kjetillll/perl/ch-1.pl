#https://theweeklychallenge.org/blog/perl-weekly-challenge-306/

sub sos {  #sum odd subarrays
    eval join '+', #sum
    map {
        my $len = $_;
        map @_[ $_ .. $_+$len-1 ], 0 .. @_ - $len  #elems in all subarrays of length $len
    }
    grep $_ % 2, #only odd lengths
    1 .. @_;     #sub array lengths
}

use Test::More tests => 2;
is sos( @{ $$_{input} } ), $$_{output} for
{input => [2,5,3,6,4], output => 77},
{input => [1,3],       output => 4}
    
