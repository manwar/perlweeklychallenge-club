#!/usr/bin/env perl6

my $msg1 = '
   H x l 4 !
   c e - l o
   z e 6 l g
   H W l v R
   q 9 m # o 
';

my $msg2 = '
   P + 2 l ! a t o
   1 e 8 0 R $ 4 u
   5 - r ] + a > /
   P x w l b 3 k \
   2 e 3 5 R 8 y u
   < ! r ^ ( ) k 0
';

say decipher($msg1);
say decipher($msg2);

sub decipher(Str:D $msg) {
    my @AoL;
    my $result;

    for $msg.split(/\n/, :skip-empty) -> $str {
        @AoL.push($str.trim-trailing.comb(/\S/).List);    
    }

    for [Z] @AoL -> $list {
        $list.Str ~~ /(\S) .* {} :my $letter = $0; $letter/;
        $result ~= $letter;
    }

    return $result;
}
