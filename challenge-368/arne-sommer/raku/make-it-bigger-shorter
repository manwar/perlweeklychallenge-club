#! /usr/bin/env raku

unit sub MAIN ($str is copy where $str  ~~ /^ <[0..9]>+ $/,
               $char        where $char ~~ /^ <[0..9]>  $/,
               :v(:$verbose));

my $last-resort = $str.rindex($char) // Inf;

say ": Index of Last Resort: $last-resort" if $verbose;

for 0 .. $str.chars -1 -> $i
{
  say ": str[$i]: { $str.substr($i,1) }" if $verbose;

  if $str.substr($i,1) == $char && ($i == $last-resort || $str.substr($i+1,1) > $char)
  {
    say ": Removal { $i == $last-resort ?? "of last resort" !! "to a greater overall value { $str.substr($i+1,1) }" } at str[$i]" if $verbose;
    $str.substr-rw($i,1) = "";
    last;
  }
}

say $str;
