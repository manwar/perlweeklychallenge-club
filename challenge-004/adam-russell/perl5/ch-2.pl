use strict;
use warnings;
##
# You are given a file containing a list of words (case insensitive 1 word per line) 
# and a list of letters. Print each word from the file than can be made using only 
# letters from the list. You can use each letter only once (though there can be 
# duplicates and you can use each of them once), you don’t have to use all the letters. 
##
use boolean;

my @words=qw| 
    cat
    mouse
    rabbit
    horse
    sheep
    cow
    aardvark
|; 

my @letters = qw|  
    a b c e h i o p r s t w b e z      
|;  

sub contains_remove{
    my($c) = @_;  
    return sub{
        my($word) = @_;  
        $word =~ s/$c//; 
        return $word;     
    }  
} 

my @checks;
for my $c (@letters){
    push @checks, contains_remove(lc($c));  
} 

sub check_word{
    my($word, $checks) = @_;
    if($word && !@{$checks}){
        return false;  
    } 
    $word = &{$checks->[0]}($word);
    if(!$word){
        return true;  
    }  
    check_word($word, [@{$checks}[1 .. @{$checks} - 1]]);
}  

for my $w (@words){
    if(check_word(lc($w), \@checks)){
        print "$w\n";  
    }   
}   
