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
    Int $number where { $_ > 0 }, #= a positive integer
    Int $mode where {$_ == 0 || $_ == 1 } #= 0 or 1
) {
    if $mode == 0 {
        factorize($number).unique.elems.say;
    } else {
        factorize($number).elems.say;
    }
}
