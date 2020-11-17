#!/usr/bin/env perl6
use v6;

sub diffpair($n, @a) {
    @a.combinations(2).map({ $_, ($_[1],$_[0]) }).map(|*).first({$_[1]-$_[0]==$n}, :v)
}

my $res=diffpair(@*ARGS[0].Int, @*ARGS[1..*].map(*.Int));
say ($res) ?? ("1: $res[1]-$res[0]=@*ARGS[0]") !! ("0")

# run as <script> <difference> <space-separated array entries>

