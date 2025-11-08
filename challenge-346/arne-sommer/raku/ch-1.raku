#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^ <[\(\)]>+ $/,
               :v(:$verbose));

my $balanced := gather
{
  for ^($str.chars) -> $i
  {
    my $match   = "";
    my $balance = 0;

    for $str.substr($i).comb -> $char
    {
      if $char eq "("
      {
        $balance++;
        $match ~= "(";
      }
      elsif $balance == 0
      {
	last;
      }
      else
      {
        $balance--;
        $match ~= ")";
      }

      take { index => $i, match => $match } if $balance == 0;
    }
  }	
}

my $longest = 0;

for $balanced -> $curr
{
  my $length = $curr<match>.chars;
  my $is-max = $length > $longest;

  $longest = $length if $is-max;

  say ": Candidate '{ $curr<match> }' at index $curr<index> { $is-max ?? " -> new max $length" !! "" }" if $verbose;
}

say $longest;
