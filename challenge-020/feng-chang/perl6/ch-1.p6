#!/bin/env perl6

sub MAIN($str = 'ABBCDEEF') { $str.comb(/(.)$0*/).say }
