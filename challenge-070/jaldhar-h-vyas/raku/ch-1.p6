#!/usr/bin/perl6

multi sub MAIN(
    Int $C, #= swap count
    Int $O, #= offset
    Str $S  #= string (length <= count + offset)
    where { $C >= 1 && $O >= 1 && $C <= $O && ($C + $O) <= $S.chars}
) {
    my $N = $S.chars;
    my @chars = $S.comb;

    for 1 .. $C -> $i {
        my $a = $i % $N;
        my $b = ($i + $O) % $N;
        my $temp = @chars[$a];
        @chars[$a] = @chars[$b];
        @chars[$b] = $temp;
    }

    @chars.join(q{}).say;
}