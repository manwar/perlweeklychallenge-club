use strict;
use warnings;
##
# You are given two positive integers, $n and $k.
# Write a script to find out the Prime Partition of the given number. 
# No duplicates are allowed.
##
use boolean;
use Math::Combinatorics;

sub sieve_atkin{
    my($upper_bound) = @_;
    my @primes = (2, 3, 5);
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

sub prime_partition{
    my($n, $k) = @_;
    my @partitions;
    my @primes = sieve_atkin($n);
    my $combinations = Math::Combinatorics->new(count => $k, data => [@primes]);
    while(my @combination = $combinations->next_combination()){
        push @partitions, [@combination] if unpack("%32I*", pack("I*", @combination)) == $n;
    }
    return @partitions;
}

MAIN:{
    my($n, $k);
    $n = 18, $k = 2;
    map{ 
        print "$n = " . join(", ", @{$_}) . "\n"
    } prime_partition($n, $k);
    print"\n\n";
    $n = 19, $k = 3;
    map{ 
        print "$n = " . join(", ", @{$_}) . "\n"
    } prime_partition($n, $k);
}