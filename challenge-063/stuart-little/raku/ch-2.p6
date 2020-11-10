#!/usr/bin/env perl6
use v6;

sub rt(Str $s, Int $n where * > 0) {
    $s.substr(($n % $s.chars)) ~ $s.substr(0..^($n % $s.chars))
}

my $word=@*ARGS[0];
say (1..*).first({ rt($word, ($_*($_+1)/2).Int) eq $word }, :k)+1

# run as <script> <word>
