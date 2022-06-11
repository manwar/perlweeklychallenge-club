use strict;
use warnings;
##
# Write a script to produce the first eight Fortunate Numbers (unique and sorted).
##
use boolean;
use Math::Primality qw/is_prime/;

use constant N => 10_000; 

sub sieve_atkin{
    my($n) = @_;
    my @primes = (2, 3, 5);
    my $upper_bound = int($n * log($n) + $n * log(log($n)));
    my @atkin = (false) x $upper_bound;    
    my @sieve = (1, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 49, 53, 59);
    for my $x (1 .. sqrt($upper_bound)){
        for(my $y = 1; $y <= sqrt($upper_bound); $y+=2){
            my $m = (4 * $x ** 2) + ($y ** 2);
            my @remainders;  
            @remainders = grep {$m % 60 == $_} (1, 13, 17, 29, 37, 41, 49, 53) if $m <= $upper_bound; 
            $atkin[$m] = !$atkin[$m] if @remainders; 
        }          
    } 
    for(my $x = 1; $x <= sqrt($upper_bound); $x += 2){
        for(my $y = 2; $y <= sqrt($upper_bound); $y += 2){
            my $m = (3 * $x ** 2) + ($y ** 2);
            my @remainders;  
            @remainders = grep {$m % 60 == $_} (7, 19, 31, 43) if $m <= $upper_bound; 
            $atkin[$m] = !$atkin[$m] if @remainders; 
        }          
    }   
    for(my $x = 2; $x <= sqrt($upper_bound); $x++){
        for(my $y = $x - 1; $y >= 1; $y -= 2){
            my $m = (3 * $x ** 2) - ($y ** 2);
            my @remainders;  
            @remainders = grep {$m % 60 == $_} (11, 23, 47, 59) if $m <= $upper_bound;
            $atkin[$m] = !$atkin[$m] if @remainders; 
        }          
    } 
    my @m;
    for my $w (0 .. ($upper_bound / 60)){
        for my $s (@sieve){
            push @m, 60 * $w + $s;  
        }
    }
    for my $m (@m){
        last if $upper_bound < ($m ** 2);
        my $mm = $m ** 2;
        if($atkin[$m]){
            for my $m2 (@m){
                my $c = $mm * $m2;
                last if $c > $upper_bound;
                $atkin[$c] = false;
            }
        }
    }
    map{ push @primes, $_ if $atkin[$_] } 0 .. @atkin - 1;
    return @primes; 
}

sub first_n_fortunate{
    my($n) = @_;
    my @primes = sieve_atkin(N);
    my @fortunates;
    my $x = 1;
    do{
        my @first_n_primes = @primes[0 .. $x - 1];
        my $product_first_n_primes = 1;
        map {$product_first_n_primes *= $_} @first_n_primes;
        my $m = 1;
        do{
            $m++;
        }while(!is_prime($product_first_n_primes + $m));
        if(!grep {$m == $_} @fortunates){
             unshift @fortunates, $m;
        }
        $x++;
    }while(@fortunates != $n);
    return sort {$a <=> $b} @fortunates;
}

MAIN:{
    print join(", ", first_n_fortunate(8)) . "\n";
}