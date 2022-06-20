#!/usr/bin/raku

sub factorize(Int $N) {
    my $n = $N;
    my @primeFactors;

    while $n %% 2 {
        @primeFactors.push(2);
        $n /= 2; 
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
) {
    my $n = 2;
    my @brilliants;

    until @brilliants.elems == 20 {
        my @factors = factorize($n);
        if @factors.elems == 2 && @factors[0].chars == @factors[1].chars {
            @brilliants.push($n);
        }
        $n++;
    }

    @brilliants.join(q{, }).say;
}
