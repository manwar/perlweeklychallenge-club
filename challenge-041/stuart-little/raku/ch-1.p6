#!/usr/bin/env perl6
use v6;

my @prms=(2..*).grep(*.is-prime);

sub fct(Int $n where * > 0) {
    given $n {
	when 1 { () }
	default {
	    my $fct=@prms.first($n %% *);
	    ($fct, |fct(($n/$fct).Int))
	}
    }
}

say (2..((@*ARGS) ?? (@*ARGS[0].Int) !! (50))).grep({ fct($_).is-prime })

# run as <script> <top number to check> or just <script> to default to range 2..50
