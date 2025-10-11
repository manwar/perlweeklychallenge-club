#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^ <[0..9 a..z]>+ $/,
               :v(:$verbose));

my @letters = $str.comb.grep( * eq any("a" .. "z") ).sort;
my @digits  = $str.comb.grep( * eq any("0" .. "9") ).sort;

my $letters = @letters.elems;
my $digits  = @digits.elems;

if $verbose
{
  say ": $letters letters: { @letters.join(", ") } (sorted)";
  say ": $digits digits: { @digits.join(", ") } (sorted)";
}

if $digits == $letters || $digits == $letters +1
{
  say roundrobin(@digits, @letters).flat.join;
}
elsif $digits == $letters -1
{
  say roundrobin(@letters, @digits).flat.join;
}
else
{
  say "";
}
