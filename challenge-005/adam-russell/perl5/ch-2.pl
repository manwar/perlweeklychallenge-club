use strict;
use warnings;  
##
# Write a program to find the sequence of characters that has the most anagrams.
##
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
my %factor_letter = reverse(%letter_factor);  

sub prime_factor{
    my $x = shift(@_); 
    my @factors;    
    for (my $y = 2; $y <= $x; $y++){
        next if $x % $y;
        $x /= $y;
        push @factors, $y;
        redo;
    }
    return @factors;  
}

##
# Main
##
while(<>){
    chomp($_);
    my $word = lc($_);
    $word =~ tr/-//d;
    my @letters = split(//, $word);
    my $product = 1;
    map {$product *= $_} map{$letter_factor{$_}} @letters;
    $word_product{$word} = $product;
}

my @words = keys(%word_product);
my %product_count;  
for my $word (@words){
    $product_count{$word_product{$word}} ||= 0;  
    $product_count{$word_product{$word}}++; 
}

my @sorted = sort {$product_count{$b} <=> $product_count{$a}} keys %product_count;
print join(" ", map {$factor_letter{$_}} prime_factor($sorted[0])) . "\n";   
