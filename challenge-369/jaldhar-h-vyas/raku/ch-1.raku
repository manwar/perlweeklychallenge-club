#!/usr/bin/raku

sub MAIN(
    Str $caption
) {
    my @words = $caption.words;
    my $result = @words[0].lc ~ @words[1..*].map({ $_.tc }).join;
    $result = q{#} ~ $result.subst(/<-[A..Za..z]>/, q{}, :g);
    say $result.chars <= 100 ?? $result !! $result.substr(0, 100);  
}
