unit sub MAIN(
    UInt $n where * < 10, #= positive number, less than 10
);

my @num-to-str = <zero one two three four five six seven eight nine>;

multi sub four-is-magic(4 --> Str) {
    return "four is magic.";
}

multi sub four-is-magic(Int $n where * < 10 --> Str) {
    my $n-str = @num-to-str[$n];
    return "$n-str is { @num-to-str[$n-str.chars] }, " ~ four-is-magic($n-str.chars);
}

put four-is-magic($n).tc;
