#!/usr/bin/raku

sub factorize(Int $N) {
    my $n = $N;
    my @primeFactors;

    while $n %% 2 {
        @primeFactors.push(2);
        $n /= 2;; 
    } 
     
    loop (my $i = 3; $i <= $n.sqrt; $i += 2)  { 
        while ($n %% $i) { 
            @primeFactors.push($i); 
            $n /= $i; 
        } 
    } 
     
    if $n > 2 { 
        @primeFactors.push($n);
    }

    return @primeFactors;
}

sub isPerfect(Int $n) {
    return so (2 .. $n.sqrt).map({ $n.log($_).round(0.001); }).any %% 1;
} 

sub isPowerful(Int $n) {
    return so $n %% factorize($n).unique.map({ $_ ** 2; }).all;
} 

sub MAIN(
) {
    my $n = 2;
    my @achilles;

    until @achilles.elems == 20 {
        if  isPowerful($n) && !isPerfect($n) {
            @achilles.push($n);
        }
        $n++;
    }

    @achilles.join(q{, }).say;
}
