#!/usr/bin/perl6

sub isPrime(Int $n) {

    if ($n < 2) {
        return False;
    }

    
    if $n == 2 {
        return True;
    }

    for 2 .. $n.sqrt -> $i {
        if $n % $i == 0 {
            return False;
        }
    }

    return True;
}

multi sub MAIN() {
    my $primorial = 1;

    for 1 .. * -> $n {
        if isPrime($n) {
            $primorial *= $n;
            my  $euclidNumber = $primorial + 1;
            if !isPrime($euclidNumber) {
                say $euclidNumber;
                return;
            }
        }
    }
}