#!/usr/bin/env raku
use v6.d;

sub MAIN(Str:D $numberstr is copy) {
    $numberstr ~~ s:g/<[(),]>/ /;
    $numberstr ~~ s/^ \s+ (.*) \s+ $/$0/;
    my $nums = Bag.new($numberstr.split(/\s+/)».Int);

    my $max = $nums.values.max;
    say $max * $nums.grep(*.value == $max).elems;
}
