#!/usr/bin/perl6

multi sub MAIN(Int :$n = 1, *@series) {

    for 0 ..^ $n {
        @series = (1 ..^ @series.elems).map({ @series[$_] - @series[$_ - 1] });
    }

    @series.join(q{, }).say;
}
