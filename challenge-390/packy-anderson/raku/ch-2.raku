#!/usr/bin/env raku
use v6;

sub orderCharacters($str is copy, $k) {
  my %seen  = ($str => 1);
  my @stack = ($str);
  while ($str = @stack.shift) {
    for (0 .. $k-1) -> $i {
      my $char = $str.substr($i,1);
      my $new  = $str.substr(0..$i-1)~$str.substr($i+1)~$char;
      next if %seen{$new}:exists;
      %seen{$new}++;
      @stack.push($new);
    }
  }
  return %seen.keys.sort.head;
}

sub solution($str, $k) {
  say qq/Input: \$str = "$str", \$k = $k/;
  say qq/Output: "{orderCharacters($str, $k)}"/;
}

say "Example 1:";
solution("dbca", 1);

say "\nExample 2:";
solution("geeks", 2);

say "\nExample 3:";
solution("cbaed", 3);

say "\nExample 4:";
solution("fedcba", 4);

say "\nExample 5:";
solution("perl", 1);

say "\nExample 6:";
solution("oloolooo", 1);

say "\nExample 7:";
solution("oloooolo", 1);
