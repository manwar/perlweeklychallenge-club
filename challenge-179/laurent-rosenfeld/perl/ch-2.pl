use strict;
use warnings;
use feature qw/say/;

binmode(STDOUT, ":utf8");
my @bars = map chr, 0x2581 .. 0x2588;

for my $test ([< 2 4 6 8 10 12 10 8 6 4 2>],
    [<0 1 19 20>], [<0 999 4000 4999 7000 7999>]) {
    my @test = @$test;
    my ($min, $max) = (sort {$a <=> $b} @$test)[0, $#test];
    my $out = "";
    for my $item (@test) {
        my $h = @bars * ($item - $min) / ($max - $min);
        $h = $#bars if $h > $#bars;
        $out .= $bars[int($h)];
    }
    say "@test; min: $min; max: $max.";
    say $out, "\n";
}
