use v6;
use Test;

sub substrings (Str $in) {
    my @result = $in.comb;
    append @result,  map { .join('') }, $in.comb.rotor: $_ => 1-$_ for 2..$in.chars;
    return set @result;
}
sub largest-substring (@words) {
    my Set $intersection = substrings shift @words;
    while (my $word = shift @words) {
        $intersection ∩= substrings $word;
    }
    return $intersection.keys.max({.chars});
}
multi MAIN (*@words where *.elems > 1) {
    say largest-substring @words;
}
multi MAIN () {
    plan 2;
    my @words = <ABABC BABCA ABCBA>;
    cmp-ok largest-substring(@words), 'eq', 'ABC', "Testing 3 strings";
    @words = 'abcde' xx 5;
    cmp-ok largest-substring(@words), 'eq', 'abcde', "Testing identical strings";
}
