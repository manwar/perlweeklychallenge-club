use strict;
use warnings;
##
# You are given string $S containing alphabets A..Z only 
# and a number $N. Write a script to encrypt the given 
# string $S using Caesar Cipher with left shift of size $N.
##
sub caesar_cypher{
    my($s, $n) = @_;
    my @cypher = map { unless(ord($_) == ord(' ')){
                           my $x = ((ord($_) - $n) < ord('A')?(ord($_) - $n + 26):(ord($_) - $n)); 
                           chr($x);
                       }
                       else{
                           $_
                       }
                 } split(//, $s);
    return join("", @cypher);
}

MAIN:{
    my($S, $N);
    $S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG";
    $N = 3;
    print "$S\n";
    print caesar_cypher($S, $N) . "\n";
}