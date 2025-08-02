#!/usr/bin/env raku
use Test;

is GEL('PeRlwEeKLy'), 'L'; 
is GEL('ChaLlenge'),  'L'; 
is GEL('The'),        '';

sub GEL($str)
{
    my $set = ([(&)] $str.comb.classify({.ord < 97}, :as{.uc}).values);
    $set ?? $set.max.key !! ~Empty;
}

# I like this solution but I can't figure out a good way to return 'L'
# from all('l', 'L') 🤔 🤷

# sub GEL($str)
# {
#     my $seq := 'a'..'z' Z& 'A'..'Z';
#     $seq.grep({ $str.contains($_) }).tail
# }
