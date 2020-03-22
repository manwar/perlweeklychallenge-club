#!/usr/bin/perl
use strict;
use Algorithm::Permute;
use List::Util qw{product any}; 

# after observation on the defintion: 
# 0 and 1 won't appear in the digits of any colourful numbers.
# following from the above, we also know every colourful numbers < 10^9.
# In addition, digits have to be distinct.

my $digits = 3;#can be changed to 2, 4 or 5, 
               #both produce colourful numbers within reasonable waiting time 
my $permat = Algorithm::Permute->new([2..9],$digits);

my @colourful = ();

while(my @m = $permat->next) {

    my @box = (0) x (product(10-$digits..9)-2) ; 
    # $box[0] is for result of multiplication as 2, 
    # $box[1] is for result of a result of multiplication as 3,
    # $box[70] is for result of a result of multiplication as 72, etc..
    for my $j (0..$#m) {
        my @a = ();
        for my $i (0..$#m-$j) {
            push @a, $m[$i+$j];
        
            $box[product( @a ) - 2]++;
        }
    }
        push @colourful, scalar join( "" , @m) unless any {$_>1} @box;
}

print join "\n", sort @colourful;



