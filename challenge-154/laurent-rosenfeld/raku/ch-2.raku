my @padovans = 1, 1, 1, -> $a, $b, $c { $a + $b } ... *;
# say @padovans[0..10];  # (1 1 1 2 2 3 4 5 7 9 12)
my $max = 10;
my $prev_pad = 1;
for @padovans -> $pad {
    next if $prev_pad == $pad;
    if $pad.is-prime {
        print "$pad ";
        $max--;
    }
    $prev_pad = $pad;
    last if $max <= 0;
}
say "";
say now - INIT now;
