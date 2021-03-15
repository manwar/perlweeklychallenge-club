#!/usr/bin/env perl6
use v6;

# run <script> <string> <singly-quoted pattern>
# escape literal '*' and '?' in the pattern with backslashes, as in '\*' or '\?'

my $rx = '^' ~ (S:g/<!after \\>\?/./ with (S:g/<!after \\>\*/.*/ with @*ARGS[1])) ~ '$';

say (@*ARGS[0] ~~ /<$rx>/).Bool.Int;

	    
