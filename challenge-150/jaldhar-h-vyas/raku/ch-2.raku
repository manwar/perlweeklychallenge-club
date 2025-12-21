#!/usr/bin/raku

sub factorize(Int $N) {
    my $n = $N;
    my @factors;

    while $n %% 2 {
        @factors.push(2);
        $n /= 2;; 
    } 
     
    loop (my $i = 3; $i <= $n.sqrt; $i++)  { 
        while ($n %% $i) { 
            @factors.push($i); 
            $n /= $i; 
        } 
    } 
     
    if $n > 2 { 
        @factors.push($n);
    }

    return @factors;
}

sub MAIN() {
    my @squareless = (1);

    for 2 .. 500 -> $n {
        my @primeFactors = factorize($n);
        if @primeFactors == @primeFactors.unique {
            @squareless.push($n);
        }
    }

    @squareless.join(q{, }).say;
}
