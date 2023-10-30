#!/usr/bin/env -S perl -wl

print &similar_words("aba", "aabb", "abcd", "bac", "aabc"); #2
print &similar_words("aabb", "ab", "ba"); #3
print &similar_words("nba", "cba", "dba"); #0


sub similar_words {

    #-- helper sub to extract unique chars
    local *chars = sub {
        join '',
         sort {$a cmp $b}
         &my_uniq( split //, $_[0] );
    };
    
    #-- trunk of subroutine
    local %similar_words;
    foreach (@_) {
        $similar_words{ &chars($_) }++; 
    } 
    
    local $similar_words=0; #-- return value
    foreach (keys %similar_words) {
        $similar_words += &nC2( $similar_words{$_} );
    } 
    
    $similar_words;
}

sub my_uniq {
    #-- homemade uniq (drop duplicates from an array)
    local (%my_uniq);
    foreach (@_) {$my_uniq{$_}=1}
    keys %my_uniq; 
}

sub nC2 {
    #-- combinations of n items 2 at a time (pairs)
    ($_[0] < 2) ? 0 : ($_[0]*($_[0]-1)/2);
}


