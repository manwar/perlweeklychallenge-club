#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 0,
               :v(:$verbose));

my @words  = $str.words;
my $words  = @words.elems;
my $spaces = $str.comb.grep( * eq " " ).elems;

my $fill   = $words == 1 ?? 0 !! $spaces div ($words - 1);
my $trail  = $words == 1 ?? $spaces !! $spaces - $fill * ($words - 1);

say ":w:$words s:$spaces f:$fill t:$trail" if $verbose;

say '"' ~ @words.join(" " x $fill) ~ (" " x $trail) ~ '"';