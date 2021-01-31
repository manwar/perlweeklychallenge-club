=begin

TASK #1 › Caesar Cipher
Submitted by: Mohammad S Anwar
You are given string $S containing alphabets A..Z only and a number $N.

Write a script to encrypt the given string $S using Caesar Cipher with left shift of size $N.

    Example
        Input: $S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG", $N = 3
        Output: "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD"
        
        Plain:    ABCDEFGHIJKLMNOPQRSTUVWXYZ
        Cipher:   XYZABCDEFGHIJKLMNOPQRSTUVW
        
        Plaintext:  THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
        Ciphertext: QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD

=end
=cut

use strict;
use warnings;
use Data::Dumper;

my $input = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG";
my $N = 3;

my @plain = ("A" .. "Z");
my @sentence = split(//, $input);
my $counter = $N;

my %hash;
my $i;
my $output = "";

cipher();
sub cipher {
    foreach ($i = 0; $i < (26 - $N); $i++) {
        $hash{$plain[$counter]} = $plain[$i];
        $counter++;
    }
    
    foreach (my $j = 0; $j < $N; $j++) {
            $hash{$plain[$j]} = $plain[$i];
            $i++;
    }
    encrypt();
}

sub encrypt {
    foreach (my $k = 0; $k < @sentence; $k++) {
        if ($sentence[$k] eq " ") {
            $output = $output." ";
        }
        else {
            $output = $output.$hash{$sentence[$k]};
        }
    }
    print "$output\n";
}