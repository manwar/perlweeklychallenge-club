#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS=:named-anywhere,;
sub MAIN(
    Str :s(:sep(:$separator)) where *.chars==1 ='/',
    *@DIRECTORIES,
    ) {
    @DIRECTORIES[0] ~~ m:exhaustive/(^.*) <?before $separator || $>/;
    say $/.map(*.Str).grep(! *.ends-with($separator)).first( -> $dir { @DIRECTORIES.all ~~ /^$dir(\/ || $)/ })
}
