#!/usr/bin/env perl6
use v6;

# run as <script> <lower bound> <upper bound>

sub left_half_strb(Int $digits where * > 0) {
    my @digits=(0,1,6,8,9);
    $digits==1 && return @digits[1..*-1];
    return (@digits[1..*-1], |(@digits xx ($digits-1))).reduce(&infix:<X>).map(*.join)
}

sub strb(Int $digits where * > 0) {
    given $digits {
	when 1 { (1,8) }
	my @halves=left_half_strb($digits div 2);
	when * %% 2 { @halves Z~ @halves.map(*.flip.trans('69'=>'96')) }
	default { (@halves X~ (0,1,8)).map({ $_ ~ $_.substr(0,($digits div 2)).flip.trans('69'=>'96') }) }
    }
}

multi sub strb_bd($low, $high where *.chars==$low.chars) {
    my $digits=$low.chars;
    strb($digits).grep({ $low le $_ le $high })
}

multi sub strb_bd($low, $high) {
    my @low=strb($low.chars).grep({ $low le $_ });
    my @mid=($low.chars^..^$high.chars).map({ |strb($_) });
    my @high=strb($high.chars).grep({ $_ le $high });
    (|@low, |@mid, |@high)
}

say strb_bd(|@*ARGS[0,1].map(*.Int))
