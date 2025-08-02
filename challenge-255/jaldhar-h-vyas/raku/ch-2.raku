#!/usr/bin/raku

sub MAIN(
    Str $p,  #= a paragraph
    Str $w   #= a banned word
) {
    my %count;
    my @words = $p.split(/<[\s \, \.]>+/);
  
    for @words -> $word {
        %count{$word}++;
    }
    %count{$w}:delete;

    %count.keys.sort({ %count{$^b} <=> %count{$^a} }).first.say;
}
