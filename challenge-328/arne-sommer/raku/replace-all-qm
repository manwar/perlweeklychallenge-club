#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^<[a..z \?]>+$/,
               :v(:$verbose));

my @str    = $str.comb;
my $prev   = '';
my $result = '';
my $end    = @str.end;

for 0 .. $end -> $index
{
  my $current = @str[$index];
  my $next    = $index >= $end ?? "" !! @str[$index +1];

  if $current eq '?'
  {
    say ": Replace ? with anything != ($prev, $next)" if $verbose;
    my $s = ('a' .. 'z') (-) ($prev, $next);
    my $pick = $s.pick;
    say ": From: { $s.keys.sort.join(",") } -> $pick" if $verbose;

    $result ~= $pick;
    $prev    = $pick;
  }
  else
  {
    say ": Added normal letter $current" if $verbose;
    $result ~= $current;
    $prev    = $current;
  }
}

say $result;
