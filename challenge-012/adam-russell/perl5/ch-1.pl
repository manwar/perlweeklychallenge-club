use strict;
use warnings;
##
# The numbers formed by adding one to the products of the smallest primes 
# are called the Euclid Numbers. Write a script that finds the smallest 
# Euclid Number that is not prime
##
use boolean; 
use LWP::UserAgent;
use constant PRIME_URL => "http://primes.utm.edu/lists/small/10000.txt";

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

sub find_nth_euclid{
    return eval(join("*", @_)) + 1;       
}

sub is_prime{
    my($n) = @_; 
    for my $i (2 .. int(sqrt($n))){
        return false if(($n % $i) == 0);
    }
    return true; 
}  

##
# Main
##
my @primes = get_primes(); 
foreach my $i (0..(@primes - 1)){
    my $euclid = find_nth_euclid(@primes[0 .. $i]); 
    if(!is_prime($euclid)){
        print "E_" . ($i + 1) . " = $euclid is composite.\n";
        exit; 
    }    
}
print "No composite Euclid Number found in the first " . @primes . " primes.\n"; 
