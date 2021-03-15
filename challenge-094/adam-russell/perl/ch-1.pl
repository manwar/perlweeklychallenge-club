use strict;
use warnings;
##
# You are given an array of strings @S.
# Write a script to group Anagrams together 
# in any random order.
##   
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

MAIN:{
    my $word;
    my %anagrams;
    while($word = <DATA>){
        chomp($word); 
        my @letters = split(//, $word);
        my $word_product = 1;
        map {$word_product *= $_} map{$letter_factor{$_}} @letters;
        push @{$anagrams{$word_product}} , $word if $anagrams{$word_product};  
        $anagrams{$word_product} = [$word] unless $anagrams{$word_product};  
    }  
    close(DATA);
    print "Organized anagrams:\n";
    for my $key (keys %anagrams){
        print "  "; 
        for my $word (@{$anagrams{$key}}){
            print "$word ";
        }
        print "\n";
    }   
}   

__DATA__
opt
bat
saw
tab
pot
top
was
