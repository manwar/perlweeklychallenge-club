#! /usr/bin/env raku

unit sub MAIN ($file where $file.IO.e && $file.IO.r = "input.txt");

my %freq = $file.IO.slurp.trans(/<[."(),]>/ => ' ').subst("'s", " ", :global).subst("--", " ", :global).words.Bag;

my @freq;

%freq.keys.sort.map({ @freq[%freq{$_}] ~= $_ ~ " " });

@freq.keys.grep({ @freq[$_] }).map({ say "$_ { @freq[$_] }" }); 
