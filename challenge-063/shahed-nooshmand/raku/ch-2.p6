#!/usr/bin/env raku

say find-r “xyxyxy”;

sub find-r($string) {
    my $p = find-p $string;
    .return when $_ × ($_ + 1) ÷ 2 %% $p for 1..∞
}

sub find-p($string) {
    my $n = chars $string;
    .return when $string.substr(^$_) x $n ÷ $_ eq $string for |(1..$n ÷ 2).grep($n %% *), $n
}
