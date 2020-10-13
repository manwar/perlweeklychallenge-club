#!/bin/env raku

my regex omits { <[."(),]> | "'s" | "--" };
my %freqs;

'input.txt'.IO.slurp.subst(/<omits>/, ' ', :g).words.map:{ ++%freqs{$_} };

my %voc;
for %freqs.kv -> $k, $v {
    %voc{$v}.push($k);
}

for %voc.keys.sort -> $k {
    say "$k { %voc{$k}.join(' ') }";
}
