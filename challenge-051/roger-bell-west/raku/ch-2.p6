#! /usr/bin/perl6

for (2..9) -> $a { # 1?? will never be colourful
  for (2..9) -> $b { # ?0? and ?1? will never be colourful
    if ($a==$b) {
      next;
    }
    for (2..9) -> $c { # ??0 and ??1 will never be colourful
      if ($a==$c || $b==$c) {
        next;
      }
      my %p;
      %p{$a}++;
      %p{$b}++;
      %p{$c}++;
      %p{$a*$b}++;
      %p{$b*$c}++;
      %p{$a*$b*$c}++;
      if (max(values %p) < 2) {
        say "$a$b$c";
      }
    }
  }
}
