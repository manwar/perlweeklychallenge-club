use strict;
use warnings;
##
# Write a script to print the first 10 sexy prime numbers.
##
use boolean; 
use LWP::UserAgent;
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

MAIN:{
    my @sexy;   
    my @primes = get_primes();  
    for my $i (0 .. (@primes - 1)){
        for my $j (($i + 1) .. (@primes - 1)){
            last if($primes[$j] - $primes[$i] > 6); 
            push @sexy, [$primes[$i], $primes[$j]] if($primes[$j] - $primes[$i] == 6); 
            last if(@sexy == 10); 
        }  
        last if(@sexy == 10); 
    }   
    for my $pair (@sexy){
        print "[" . join(", ", @{$pair}) . "]";  
    }
    print "\n";
}  
