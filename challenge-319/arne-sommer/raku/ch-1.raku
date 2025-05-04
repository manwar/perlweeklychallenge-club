#! /usr/bin/env raku

subset VOWEL where * ~~  /<[aeiouyAEIOUY]>/;

unit sub MAIN (*@list where @list.elems > 1 && all(@list) ~~ /^<[a..z A..Z]>+$/,
               :v(:$verbose));

my @matches = @list.grep({ .substr(0,1) ~~ VOWEL || .substr(.chars -1,1) ~~ VOWEL});

say ": Matching words: @matches[]" if $verbose;

say @matches.elems ?? @matches.elems !! -1;
