#!/usr/bin/env raku

my @doors-open = 501 xx False;

for 1..500 -> $inc {
    my $cur = $inc;
    while $cur <= 500 {
        @doors-open[$cur] = ! @doors-open[$cur];
        $cur += $inc;
    }
}

for 1..500 -> $door {
    say "$door is Open" if @doors-open[$door];
}
