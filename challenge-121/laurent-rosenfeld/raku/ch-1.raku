use v6;

sub invert-bit (UInt $m where * <=255, UInt $n where 1 <= * <= 8) {
    my $bin = $m.fmt("%08b");
    # say $bin;
    my $bit = $bin.substr(*-$n, 1);
    $bin.substr-rw(*-$n, 1) = $bit == 0 ?? 1 !! 0;
    # say $bin;
    return $bin.parse-base(2);
}
for 12, 3,
    18, 4,
    249, 1 {
    say "$^a $^b => ", invert-bit $^a, $^b;
}
