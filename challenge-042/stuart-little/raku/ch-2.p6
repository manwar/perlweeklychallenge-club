#!/usr/bin/env perl6
use v6;

grammar BAL {
    regex TOP { <expr>* }
    regex expr { '(' <expr>* ')' }    
}

given @*ARGS[0] {
    when /^\d+$/ {
	say "Random string of parens: ", my $s=<( )>.roll(@*ARGS[0].Int).join;
	say "Balanced: ", BAL.parse($s).Bool
    }
    when /^<[()]>*$/ {
	say "Balanced: ", BAL.parse(@*ARGS[0]).Bool
    }
}

# run as <script> <number of parentheses> or
# <script> <single-quoted string of parens>
