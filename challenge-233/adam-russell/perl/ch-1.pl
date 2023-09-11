use v5.38;
##
# You are given an array of words made up of alphabets only. Write a script to find the 
# number of pairs of similar words. Two words are similar if they consist of the same 
# characters.
##
use boolean;

sub is_similar{
    my($s0, $s1) = @_;
    my(%h0, %h1);
    do { $h0{$_} = undef } for split //, $s0; 
    do { $h1{$_} = undef } for split //, $s1; 
    return false if keys %h0 != keys %h1;
    do { return false if !exists $h1{$_} } for keys %h0;
    return true;
}

sub similar_words_pairs_count{
    my @words = @_;
    my @similar;
    do{
        my $word_index = $_;
        my @similar_temp = grep { $words[$word_index] ne $words[$_] && 
                                  is_similar $words[$word_index], $words[$_] } $word_index + 1 .. @words - 1;
        push @similar, @words[@similar_temp] if @similar_temp > 0;
    } for 0 .. @words - 1;
    return @similar + 0;
}

MAIN:{
    say similar_words_pairs_count qw/aba aabb abcd bac aabc/;
    say similar_words_pairs_count qw/aabb ab ba/;
    say similar_words_pairs_count qw/nba cba dba/;
}