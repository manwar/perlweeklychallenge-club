#!/usr/bin/env raku

my %hail = 1 => 1;

for 1..^1e6 {
    my $n = $_;
    my $i = 0;
    until %hail{$n}:exists {
    	$n = $n %% 2 ?? $n ÷ 2 !! $n × 3 + 1;
    	$i++
    }
    %hail{$_} = $i + %hail{$n}
}

.put for %hail.sort(−*.value)[^20]
