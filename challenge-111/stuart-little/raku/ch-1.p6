#!/usr/bin/env perl6
use v6;

# run <script>

use  MONKEY-SEE-NO-EVAL;

my @ar = [
    [  1,  12,  3,  5,  7 ],
    [  9, 11, 15, 19, 20 ],
    [ 23, 24, 25, 29, 31 ],
    [ 32, 33, 39, 40, 42 ],
    [ 45, 47, 48, 49, 50 ],
    ];
say "Array:";
for (@ar) -> @row {
    say @row;
}
say "";

my $arrStr = @ar.map(|*).join(',');
my &fun = EVAL 'use List::AllUtils qw(bsearchidx); sub f {bsearchidx {$_ - $_[0]} \qq[$arrStr]}; \&f', :lang<Perl5>;

my @toSearch=(1,35,39,100);

for (@toSearch) {
    say "Found $_?";
    say (fun($_) >= 0) ?? (1) !! (0);
}

