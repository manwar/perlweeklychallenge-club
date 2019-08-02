#!/usr/bin/perl6

multi sub MAIN(
    Str $word, #= Find anagrams for this word.
    Str $list  #= List of words to search for anagrams.
) {
    my $search = $word.comb.sort.join; 
    my %dictionary = $list.IO.lines.map({ $_ => $_.comb.sort.join });

    my %anagrams;
    for %dictionary.kv -> $key, $value {
        %anagrams{$value}.push($key);
    }

    if (%anagrams{$search}:exists) {
        say %anagrams{$search}.grep({ $_ !~~ $word }).sort.join(' ');
    }
}
