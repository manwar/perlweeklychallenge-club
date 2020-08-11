use v6;

sub MAIN ($input = "The quick brown fox jumps over the lazy dog") {
    my %bin_chars = '.' => 1, '_' => 111;
    my %*bin-morse = "morse.dat".IO.lines.map({
        my ($key, $val) = split ":", $_ ;
        my $bin_val = $val.comb.map({%bin_chars{$_}}).join('0');
        $key => $bin_val;
    });
    say "Input string: $input";
    my $encoded = to_morse $input;
    say "Binary encoded Morse string:";
    my $encoded-copy = $encoded;
    .Str.say for $encoded-copy ~~ s:g/(. ** 1..80)/$0\n/;
    say "Decoded string: ", from_morse $encoded;
}
sub to_morse ($input is copy) {
    $input ~~ s:i:g/<-[A..Z0..9\s.,?'!;]>//; # remove non Morse characters
    my @morse_words;
    for $input.uc.split(/\s/) -> $word {
        push @morse_words, join '000', map { %*bin-morse{$_} }, $word.comb;
    }
    return join '0000000', @morse_words;
}
sub from_morse ($input) {
    my %rev_bin-morse = reverse %*bin-morse.kv;
    my @words;
    for split /0 ** 7/, $input -> $word {
         push @words, join '', map {%rev_bin-morse{$_}}, split /000/, $word;
    }
    return join " ", @words;
}
