use strict;
use warnings;
##
# Using only the official postal (2-letter) abbreviations for 
# the 50 U.S. states, write a script to find the longest English 
# word you can spell.
##
my %word_product;
my %letter_factor = (
    AL => 2,
    AK => 2,
    AZ => 2,
    AR => 2,
    CA => 2,
    CO => 2,
    CT => 2,
    DE => 2,
    FL => 2,
    GA => 2,
    HI => 2,
    ID => 2,
    IL => 2,
    IN => 2,
    IA => 2,
    KS => 2,
    KY => 2,
    LA => 2,
    ME => 2,
    MD => 2,
    MA => 2,
    MI => 2,
    MN => 2,
    MS => 2,
    MO => 2,
    MT => 2,
    NE => 2,
    NV => 2,
    NH => 2,
    NJ => 2,
    NM => 2,
    NY => 2,
    NC => 2,
    ND => 2,
    OH => 2,
    OK => 2,
    OR => 2,   
    PA => 2,    
    RI => 2,
    SC => 2,    
    SD => 2,
    TN => 2,
    TX => 2,
    UT => 2,
    VT => 2,
    VA => 2,
    WA => 2,
    WV => 2,
    WI => 2,
    WY => 2
);
map { $letter_factor{ lc($_) } = $letter_factor{ $_ }; delete($letter_factor{ $_ }) } keys %letter_factor;

##
# Main
##
while(<>){
    chomp($_);
    my $word = lc($_);
    $word =~ tr/-//d;
    my @letters = split(//, $word);
    if(@letters % 2 == 0){ 
        my @two_letter_chunks;
        for(my $i = 0; $i < @letters; $i+=2){  
            push @two_letter_chunks, $letters[$i] . $letters[$i + 1];  
        } 
        my $product = 1;
        map {$product *= $_} map{defined($letter_factor{$_}) ? $letter_factor{$_} : 0} @two_letter_chunks;
        $word_product{$word} = $product if($product > 0);
    }  
}
my @sorted = sort {$word_product{$b} <=> $word_product{$a}} keys %word_product;
print $sorted[0] . "\n";  
