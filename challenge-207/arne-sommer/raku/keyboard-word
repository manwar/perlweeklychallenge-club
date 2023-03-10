#! /usr/bin/env raku

unit sub MAIN ($words = "Hello Alaska Dad Peace", :v($verbose));

my $row1 = /^ <[qwertyuiop]>+ $/;
my $row2 = /^ <[asdfghjkl]>+  $/;
my $row3 = /^ <[zxcvbnm]>+    $/;

my @ok;

for $words.words -> $word
{
  say ":word: $word" if $verbose;
  @ok.push($word) if $word.lc ~~ / $row1 | $row2 | $row3 /; 
}

say "(", @ok.map({ '"' ~ $_ ~ '"' }).join(","), ")";
