#! /usr/bin/env raku

unit sub MAIN (Str $str, :v(:$verbose));

my $n   = $str.chars;
my $rev = $str.flip;
my $m   = $n;

$m-- while $m > 1 && $str.substr(0, $m) ne $rev.substr($n - $m);

if $verbose
{
  say ": Palindromic prefix: { $str.substr(0, $m) }";
  say ": Prepending: { $rev.substr(0, $n - $m) }";
}

say $rev.substr(0, $n - $m) ~ $str;