#!/usr/bin/perl6

sub makeWords() {
    return '/usr/share/dict/words'.IO.lines
        .grep({ .chars < 8 && / ^ <:alpha>+ $ / })
        .classify({ $_.comb.sort.join.uc; }, :as{ uc $_; })
        .sort;
}

sub pickTiles() {
    return
        ('A' x 8 ~ 'G' x 3 ~ 'I' x 5 ~ 'S' x 7 ~ 'U' x 5 ~ 'X' x 2 ~ 'Z' x 5 ~
        'E' x 9 ~ 'J' x 3 ~ 'L' x 3 ~ 'R' x 3 ~ 'V' x 3 ~ 'Y' x 5 ~ 'F' x 3 ~
        'D' x 3 ~ 'P' x 5 ~ 'W' x 5 ~ 'B' x 5 ~ 'N' x 4 ~ 'T' x 5 ~ 'O' x 3 ~
        'H' x 3 ~ 'M' x 4 ~ 'C' x 4 ~ 'K' x 2 ~ 'Q' x 2).comb.pick(7);
}

sub calculateScore(Str $string) {
    my %scores = (
        'A' => 1, 'G' => 1, 'I' => 1, 'S' => 1,  'U' => 1, 'X' => 1, 'Z' => 1,
        'E' => 2, 'J' => 2, 'L' => 2, 'R' => 2,  'V' => 2, 'Y' => 2, 'F' => 3,
        'D' => 3, 'P' => 3, 'W' => 3, 'B' => 4,  'N' => 4, 'T' => 5, 'O' => 5,
        'H' => 5, 'M' => 5, 'C' => 5, 'K' => 10, 'Q' => 10  );

    return [+] $string.comb.map({ %scores{$_}; });
}

multi sub MAIN() {
    my %dict = makeWords();
    my @draw = pickTiles();

    my $bestScore = 0;
    my $bestWord = q{};

    for (7 ... 1) -> $length {
        for @draw.sort.combinations($length).map({ .join }) -> $tiles {
            if %dict{$tiles} {
                my $value = %dict{$tiles}.values[0];
                my $score = calculateScore($value);

                if ($score > $bestScore ||
                ($score == $bestScore && $value.chars > $bestWord.chars)) {
                    $bestScore = $score;
                    $bestWord = $value;
                }
            }
        }
    }

    say @draw.join, " = $bestWord ($bestScore)";
}