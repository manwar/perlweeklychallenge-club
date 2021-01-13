use v6;

sub last-word (Str $str, $regex) {
    for $str.words.reverse -> $reversed {
        return $reversed if $reversed ~~ $regex;
    }
    return "Not found";
}

say last-word "Hello Word", rx/<[ae]>l/;
say last-word("Don't match too much, Chet!",  rx:i/ch.t/);
say last-word("spaces in regexp won't match", rx:s/in re/);
my $str = join(' ', 1..1e5);
say last-word( $str, rx/^8 ** 3/);
