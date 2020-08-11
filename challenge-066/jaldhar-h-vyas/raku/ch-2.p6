#!/usr/bin/perl6

sub isPower($num) { 
    my @results;

    if $num == 1 {
        @results.push([1, 1].join(q{^})); 
    } else {
        for 2 .. sqrt($num) -> $m {
            my $n = 2; 
            my $p = $m ** $n; 
  
            while $p <= $num && $p > 0 { 
                if $p == $num { 
                    @results.push([$m, $n].join(q{^}));
                } 
                $n++; 
                $p = $m ** $n; 
            } 
        }
    } 

    return @results; 
}

multi sub MAIN(
    Int $N      #= number to check
) {
    my @powers = isPower($N);
    say @powers.elems ?? @powers.join(q{, }) !! 0;
}