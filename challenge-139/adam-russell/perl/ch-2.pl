use strict;
use warnings;
##
# Write a script to generate the first 5 Long Primes.
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

sub divide{
    my($n, $d) = @_; 
    my @remainders;
    my $q = (int($n / $d)) . ".";
    my $r = $n % $d; 
    push @remainders, $r; 
    my @a;
    for (0 .. $d){
        $q .= int($r*10 / $d);  
        $r = $r*10 % $d;
        @a = grep { $remainders[$_] == $r } (0 .. @remainders - 1);
        last if(@a); 
        push @remainders, $r; 
    }
    my $r_i = $a[0];
    my $i = index($q, ".");
    my $decimal_part = substr($q, $i+1); 
    return substr($q, 0, $i + 1) . substr($decimal_part, 0, $r_i) . "(" . substr($q, $i + $r_i + 1) . ")";  
}   

sub long_primes_five{
    my @long_primes;
    my @primes = get_primes();
    do{
        my $prime = shift @primes;    
        my $max_repetend = $prime - 1; 
        my $repeats = true if($prime != 2 && $prime != 5); 
        if($repeats){
            my $x = divide(1, $prime, [], []); 
            $x =~ m/\((\d+)\)/;
            my $repetend = $1;
            push @long_primes, [$prime, $x] if length($repetend) == $prime - 1;   
        }
    }while(@long_primes < 5);
    return @long_primes;
}

MAIN:{
    for my $p (long_primes_five()){
        print $p->[0] . "\t" . $p->[1] . "\n";
    }
}
