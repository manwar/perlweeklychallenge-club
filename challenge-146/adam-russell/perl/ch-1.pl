use strict;
use warnings;
##
# Write a script to generate the 10001st prime number.
##
use boolean; 
use Getopt::Long;
use LWP::UserAgent;

use constant N => 10_001;   
use constant PRIME_URL => "http://primes.utm.edu/lists/small/100000.txt";

sub get_primes{
    my @primes;
    my $ua = new LWP::UserAgent(
        ssl_opts => {verify_hostname => 0}
    );
    my $response = $ua->get(PRIME_URL);
    my @lines = split(/\n/,$response->decoded_content);
    foreach my $line (@lines){
        my @p = split(/\s+/, $line);
        unless(@p < 10){
            push @primes, @p[1..(@p - 1)];
        }
    }
    return @primes;
}

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

sub get_nth_prime{
    my($n, $generate) = @_; 
    my @primes;
    unless($generate){
        @primes = get_primes;
    }
    else{
        @primes = sieve_atkin($n);
    }
    return $primes[$n - 1]; 
}


MAIN:{
    my $n = N;
    my $generate = false;
    GetOptions("n=i" => \$n, generate => \$generate);
    print get_nth_prime($n, $generate) . "\n"; 
}
