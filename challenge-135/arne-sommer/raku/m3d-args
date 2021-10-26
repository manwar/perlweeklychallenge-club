#! /usr/bin/env raku

my $n = @*ARGS[0];

die "Not an integer" unless $n ~~ /^\-?<[1..9]><[0..9]>*$/;

$n = $n.abs if $n < 0;

if    $n.chars %% 2 { say "even number of digits"; }
elsif $n.chars < 3  { say "too short"; }
else                { say $n.substr(($n.chars - 3) /2, 3); }
