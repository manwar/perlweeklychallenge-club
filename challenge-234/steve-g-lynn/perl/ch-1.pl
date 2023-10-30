#!/usr/bin/env -S perl -wl

#-- sticking to perl 4 syntax only
#

print &common_characters("java","javascript","julia"); #aj
print &common_characters("bella","label","roller");  #ell
print &common_characters("cool","lock","cook"); #co

sub common_characters {
    #-- if just one element return it
    (scalar(@_)==1) && (return $_[0]);

    #-- helper sub subs
    local *get_chars=sub {
        #-- hash to get chars with frequency
        local ($get_chars)=@_;
        local %get_chars;
        foreach (0 .. length($get_chars)-1) {
            $get_chars{substr($get_chars,$_,1)}++;
        }
        %get_chars;
    };

    local *compare_words=sub {
       #-- compare two strings and return the common characters
       #-- as a string
       
       local (@compare_words)=@_[0..1];
       
       local (%word1, %word2, $compare_words);
       %word1=&get_chars($compare_words[0]);
       %word2=&get_chars($compare_words[1]);
       
       foreach (sort keys %word1) {
            if (defined($word2{$_}) ){
                local $num_chars=
                ( ($word2{$_} < $word1{$_}) ? 
                ($word2{$_}) : 
                ($word1{$_}) ) ;
                $compare_words .= ($_ x $num_chars);
            }
       }
       $compare_words; 
    };

    #-- back to trunk of subroutine
    #-- store common chars in first two words in return value
    #-- $common_characters
        
    local $common_characters=&compare_words($_[0],$_[1]);
    
    #-- if just 2 elements, we are through.
    ($#_ < 2) && (return $common_characters); 
    
    #-- If not, loop through the rest of the array, comparing
    #-- the common characters string to the next element. 
    #-- At each stage, replace $common_characters with 
    #-- the characters it has in common with the next element.
    
    foreach (2 .. $#_){
        $common_characters = &common_characters($common_characters, $_[$_]); 
    }
    
    #-- return
    $common_characters;
}
