#!/usr/bin/env raku
use v6;

my regex isAlternating {
  ^[ <:Ll>?[<:Lu><:Ll>]+ | <:Lu>?[<:Ll><:Lu>]+ ]$
}

my regex noalt($i) {
  (<:Lu> ** {$i} <:Ll> ** {$i} | <:Ll> ** {$i} <:Lu> ** {$i})
}

sub alternateCase($str is copy) {
  return (0, []) if $str ~~ /<isAlternating>/;
  my @swaps;
  loop {
    my $i = $str.chars div 2;
    for (1 .. $i).reverse -> $j {
      if (my $m = $str ~~ /<noalt($j)>/) {
        my $match = $m.Str;
        my $start = $m.from + (($m.chars div 2) - 1);
        my $flip = $str.substr($start, 2).flip;
        $str.substr-rw($start, 2) = $flip;
        @swaps.push($str);
        last;
      }
    }
    return (@swaps.elems, @swaps) if $str ~~ /<isAlternating>/;
  }
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  my ($count, $swaps) = alternateCase($str);
  say 'Output: ' ~ $count;
  if ($swaps) {
    say "";
    for 0..$swaps.end -> $c {
      say qq/Swap {$c+1}: "{$swaps[$c]}"/;
    }
  }
}

say "Example 1:";
solution("aAbB");

say "\nExample 2:";
solution("AAbb");

say "\nExample 3:";
solution("AAAbbb");

say "\nExample 4:";
solution("aABb");

say "\nExample 5:";
solution("bBBAaa");
