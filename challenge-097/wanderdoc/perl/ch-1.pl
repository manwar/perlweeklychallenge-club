#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given string $S containing alphabets A..Z only and a number $N. Write a script to encrypt the given string $S using Caesar Cipher with left shift of size $N.
Example

Input: $S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG", $N = 3
Output: "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD"
Plain:    ABCDEFGHIJKLMNOPQRSTUVWXYZ
Cipher:   XYZABCDEFGHIJKLMNOPQRSTUVW

Plaintext:  THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
Ciphertext: QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD

=cut

use Test::More;

sub caesar
{
     my ($str, $num) = @_;

     my @alphabet = 'A' .. 'Z';

     my %encrypt;
     $encrypt{q( )} = q( );
     @encrypt{@alphabet} = @alphabet[   $#alphabet - $num + 1 .. $#alphabet, 
                                        0 .. $#alphabet - $num];
     $str =    join '',
               map $encrypt{$_},
               split(//,$str);

     return $str;
}




is(caesar(qq(THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG), 3),
          qq(QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD), 'Example');
done_testing();