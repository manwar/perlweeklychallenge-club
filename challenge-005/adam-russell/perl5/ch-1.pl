use strict;
use warnings;
##
# Write a program which prints out all anagrams for a given word.
##
use constant DICTIONARY => "/usr/share/dict/words";  
my %word_product;
my %letter_factor = (
    e => 2,
    t => 3,
    a => 5,
    o => 7,
    i => 11,
    n => 13,
    s => 17,
    h => 19,
    r => 23,
    d => 29,
    l => 31,
    c => 37,
    u => 41,
    m => 43,
    w => 47,
    f => 53,
    g => 59,
    y => 61,
    p => 67,
    b => 71,
    v => 73,
    k => 79,
    j => 83,
    x => 89,
    q => 97,
    z => 101  
);  

##
# Main
##
my $test_word = $ARGV[0];  
$test_word =~ tr/-//d;
my @letters = split(//, $test_word);
my $test_word_product = 1;
map {$test_word_product *= $_} map{$letter_factor{$_}} @letters;
open(WORDS, DICTIONARY);  
while(<WORDS>){
    chomp($_);
    my $word = lc($_);
    $word =~ tr/-//d;
    @letters = split(//, $word);
    my $product = 1;
    map {$product *= $_} map{$letter_factor{$_}} @letters;  
    $word_product{$word} = $product;   
}  
close(WORDS);
delete($word_product{$test_word}); 
my @anagrams = grep {$word_product{$_} == $test_word_product} keys(%word_product);   
if(@anagrams){
    print "$test_word: " . join(" ", @anagrams) . "\n"; 
}   
else{
    print "$test_word: No anagrams found.\n";        
}   
