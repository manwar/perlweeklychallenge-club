#!/usr/bin/env perl6
use v6;

my $name = "\$@*ARGS[0]";
spurt 'MySymbols.pm6', "use v6; unit module MySymbols; my $name = \'@*ARGS[1]\'; say \"\\$name = $name\"";
use lib '.';
require MySymbols;
unlink 'MySymbols.pm6';

# run as <script> <variable name> <variable value>
# ref: https://stackoverflow.com/questions/47332941/how-to-define-variable-names-dynamically-in-perl-6
