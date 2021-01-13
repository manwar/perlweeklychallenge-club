#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

# Morse Code Char Set
# dot: 1
# dash: 111
# intra-character gap: 0
# character gap: 000
# word gap: 0000000

my %m_encode = ( 
    0=>489335,
    1=>96119, 
    2=>22391, 
    3=>5495,  
    4=>1367,  
    5=>341,   
    6=>1877,  
    7=>7637,  
    8=>30581, 
    9=>122333,
    A=>23,    
    B=>469,   
    C=>1885,  
    D=>117,   
    E=>1,     
    F=>349,
    G=>477,
    H=>85,
    I=>5,
    J=>6007,
    K=>471,
    L=>373,
    M=>119,
    N=>29,
    O=>1911,
    P=>1501,
    Q=>7639,
    R=>93,
    S=>21,
    T=>7,
    U=>87,
    V=>343,
    W=>375,
    X=>1879,
    Y=>7543,
    Z=>1909
);

my $string_to_encode = $ARGV[0] || "A QUICK BROWN FOX JUMPS OVER THE LAZY DOG";

sub encode {
    my $string = uc pop;
    return $string =~ 
    #Insert # in between letters using \b
    s/\B/#/gr =~ 
    #Replace space which separate words, with @
    s/ /@/gr =~ 
    #Replace alphanumeric + _ matches with the morsecode from hash table
    s/\w/sprintf "%b", $m_encode{$&}/gre =~ 
    #Replace # with the assigned character gap
    s/#/000/gr =~ 
    #Replace @ with the assigned word gap
    s/@/0000000/gr ;
}

my $encoded_string = encode($string_to_encode);

say "Encoded Morse Code: ".$encoded_string;

=begin
perl .\ch-1.pl "just another perl hacker"
Encoded Morse Code: 101110111011100010101110001010100011100000001011100011101000111011101110001110001010101000100010111010000000101110111010001000101110100010111010100000001010101000101110001110101110100011101011100010001011101
=cut