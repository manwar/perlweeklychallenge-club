#!/usr/bin/perl6

sub makeWords(Str $wordList) {
    return $wordList.IO.lines
        .grep({  /^<:alpha>+$/ })
        .map({ .lc })
        .sort;
}

multi sub MAIN(
    Str $wordList = '/usr/share/dict/words'
) {

    my @words = makeWords($wordList);
    my %spelled =  @words.map({ $_ => $_ });

    my @abbrevs = qw/
      al ak az ar ca co ct de fl ga hi id il in ia ks ky la me md ma mi mn ms mo
      mt ne nv nh nj nm ny nc nd oh ok or pa ri sc sd tn tx ut vt va wa wv wi wy
    /;

    for @words -> $word {
        for @abbrevs -> $abbrev {
            if %spelled{$word} eq q{} {
                last;
            }
            if $word.contains($abbrev) {
                %spelled{$word} ~~ s/$abbrev//;
            }
        }
    }

    my $answer = q{};

    for %spelled.keys.grep({ %spelled{$_} eq q{} }).sort -> $word {
        if ($word.chars >= $answer.chars) {
            $answer = $word;
        }
    }

    say $answer;
}