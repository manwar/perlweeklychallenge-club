#!/usr/bin/env raku
use Test;

is most-freq-pair("abcdbca"),           "bc";
is most-freq-pair("cdeabeabfcdfabgcd"), "ab";

say most-freq-pair([~] ("a".."z").roll(100_000));

multi most-freq-pair($str where .chars < 100_000)
{
    ($str ~~ m:ov/../)>>.Str.Bag.maxpairs.sort.head.key
}

multi most-freq-pair($str)
{
    my $len = ($str.chars / $*KERNEL.cpu-cores).ceiling;

    my @promises = (^$*KERNEL.cpu-cores).map(
    { 
       start { ($str.substr(($len * $_), $len+1) ~~ m:ov/../)>>.Str.Bag }
    }); 

    await @promises;

    ([(+)] @promises>>.result).maxpairs.sort.head.key
}
