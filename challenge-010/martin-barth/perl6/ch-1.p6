use Test;
my %roman2num =
    'I'  => 1,
    'V'  => 5,
    'X'  => 10,
    'L'  => 50,
    'C'  => 100,
    'D'  => 500,
    'M'  => 1000;

for test-data().kv -> $roman, $number {
    my $r = $roman.comb().reverse.map({%roman2num{$_}}).reduce({state $l = $^s; $l = $^b; $s + (($l > $b)*2-1) * $b}); #<<<
    is $r, $number, "Roman $roman - 3";
}

sub test-data {
    return (
        I => 1,
        II => 2,
        III => 3,
        IV => 4,
        V => 5,
    );
}
