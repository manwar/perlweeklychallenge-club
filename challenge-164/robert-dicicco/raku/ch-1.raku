use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-05-09
# Challenge #164 Prime Palindrome ( Raku )

for (1..1000) -> $n {
  if ((is-prime($n)) && (is-prime($n.flip)) && ($n == $n.flip)) {
    print "$n ";
  }
}

say " ";
