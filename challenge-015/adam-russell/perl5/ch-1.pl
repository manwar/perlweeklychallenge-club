use strict;
use warnings;
##
# Write a script to generate first 10 strong and weak prime numbers.
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

sub find_strong_prime{
    my($n_prev, $n, $n_next) = @_;
    if($n > (($n_prev + $n_next) / 2)){
        return true; 
    }   
    return false; 
} 

sub find_weak_prime{
    my($n_prev, $n, $n_next) = @_;
    if($n < (($n_prev + $n_next) / 2)){
        return true; 
    }   
    return false; 
} 
##
# Main
##
my(@weak, @strong);
my @primes = get_primes(); 
my @test;
push @test, shift @primes; 
push @test, shift @primes; 
while((@weak < 10 || @strong < 10) && @primes > 3){
    push @test, shift @primes; 
    if(find_strong_prime(@test) && @strong < 10){
        push @strong, $test[1]; 
    }  
    if(find_weak_prime(@test) && @weak < 10){
        push @weak, $test[1]; 
    }  
    shift @test; 
} 
if(@weak == 10 && @strong == 10){ 
    print "\tStrong\t\tWeak\n";
    print "\t======\t\t====\n";
    foreach my $i (0..9){
        print "$i:\t$strong[$i]\t\t$weak[$i]\n";
    }  
}
else{ 
    print "Ten strong/weak primes were not found in the first 100,000 primes.\n";  
} 
