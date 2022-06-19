#!/usr/bin/env raku

sub brilliant-numbers (UInt $n) {
   10 ** $n ^..^ 10** ($n+1)
   andthen .grep: *.is-prime
   andthen .cache
   andthen |.combinations(2), |($_ Z, $_)
   andthen .map: {[*] $_}\
   andthen .sort
   andthen .Slip
}

constant BrilliantNumbers = (0..Inf).map: &brilliant-numbers;

multi MAIN (Bool :test($)!) {
    use Test;
    is brilliant-numbers(0), <4 6 9 10 14 15 21 25 35 49>;
    is brilliant-numbers(1).head(10), (121, 143, 169, 187, 209, 221, 247, 253, 289, 299);
    is BrilliantNumbers.head(20), (4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121, 143, 169, 187, 209, 221, 247, 253, 289, 299);
    done-testing;
}

multi MAIN (UInt $n=20) {
    put BrilliantNumbers.head: $n
}
