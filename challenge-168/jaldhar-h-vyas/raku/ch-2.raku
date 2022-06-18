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

sub MAIN(
    Int $n  where { $n > 1 } #= a positive integer greater than 1
) {
    my $hp = $n;
    until $hp.is-prime {
        my @factors = factorize($hp);
        $hp = @factors.join(q{}).Int;
    }

    say $hp;
}
