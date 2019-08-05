use v6;

my $codes = set <
    AL AK AZ AR CA CO CT DE FL GA
    HI ID IL IN IA KS KY LA ME MD
    MA MI MN MS MO MT NE NV NH NJ
    NM NY NC ND OH OK OR PA RI SC
    SD TN TX UT VT VA WA WV WI WY >;

sub valid (Str $word) {
    for $word.uc.comb(2) -> $letter-pair {
        return False unless $letter-pair (elem) $codes;
    }
    return True;
}

my $longest-word = "";
my $max-size = 0;
for "words.txt".IO.lines -> $word {
    next unless $word.chars %% 2;
    $longest-word = $word and $max-size = $word.chars
        if valid $word and $word.chars > $max-size;
}
say $longest-word;
