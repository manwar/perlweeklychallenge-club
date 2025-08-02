#!/usr/bin/env raku
use v6.d;

sub MAIN(Str:D $numberstr is copy) {
    $numberstr ~~ s:g/<[(),]>/ /;
    $numberstr ~~ s/^ \s+ (.*) \s+ $/$0/;
    my @hours = $numberstr.split(/\s+/);

    say @hours.combinations(2).grep(*.sum %% 24).elems;
}