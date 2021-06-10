#! /usr/bin/env raku

unit sub MAIN ($x, :y(:$y-is-a-vowel));

my @vowels = $y-is-a-vowel ?? <a e i o u y> !! <a e i o u>;

my $y = $x.substr(0,1).lc eq any(@vowels) ?? $x.lc !! $x.substr(1);

say 
"$x, $x, bo-{     $x.substr(0,1).lc eq "b" ?? $y !! "b$y" }
Bonana-fanna fo-{ $x.substr(0,1).lc eq "f" ?? $y !! "f$y" }
Fee fi mo-{       $x.substr(0,1).lc eq "m" ?? $y !! "m$y" }
$x!";