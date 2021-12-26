use strict;
use warnings;
##
# Write a script to generate all Semiprime numbers <= 100.  
##
use boolean; 
use LWP::UserAgent;
use constant N => 100; 
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

sub factor{
    my($n) = @_;
    my @factors = ();
    for  my $j (2 .. sqrt($n)){
        if($j**2 == $n){  
            push @factors, [$j, $j] if $j**2 == $n;
            next; 
        }
        push @factors, [$j, $n / $j] if $n % $j == 0;
    }
    return @factors;
}

sub semiprime{
    my($n, $primes) = @_;
    my @factors = factor($n);
    return false if @factors != 1;  
    my @prime_factors = grep {$factors[0]->[0] == $_ || $factors[0]->[1] == $_} @{$primes};     
    return true if @prime_factors == 2 || $prime_factors[0]**2 == $n; 
    return false; 
}

sub semiprime_n{
    my @primes = get_primes; 
    for my $n (1 .. N){
        print "$n " if semiprime($n, \@primes);   
    } 
    print "\n"; 
}

MAIN:{
    semiprime_n;
}
