#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS=:named-anywhere,;
sub MAIN(
    Bool :c(:$csv),
    *@FILES,
    ) {

    sub freq(@a,$cflag) {
	my @bg=@a.Bag.sort({$^b.value leg $^a.value});
	(! $cflag) ??
	(@bg) !!
	(@bg.map({ $_.key ~ ',' ~ $_.value }))
    }
    
    my @a=(! @FILES)
    ?? ($*IN.lines)
    !! (@FILES.map({ $_.IO.lines }).flat);
    for freq(@a,$csv) {.say};
}

