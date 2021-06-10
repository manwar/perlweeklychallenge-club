#! /usr/bin/env raku

# Returns a list of divisors except 1 and Self.

sub get-divisors ($num){
    reduce sub (@acc,$i){
        if $num %% $i && $i != 1 && $i != $num {
            @acc.push($i) ;
            my $m = $num / $i;
            @acc.push($m) if $m != $i;
        }
        @acc;
    }, [], | (1..$num.sqrt.floor);
}

# Print 20 Chowla Numbers.
# To input the count do

# 'raku ch-1.raku --N=25'

sub MAIN(
    Int :$N = 20,
) {
    say ([1..$N].map(  {[+] get-divisors($_)}  )).join(",");
}
