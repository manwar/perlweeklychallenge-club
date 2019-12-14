#!/usr/bin/env perl6

my token date-number {
  ^
  ( ( <[12]> ) ( <[0..9]> ** 2 ) )
  ( <[0..9]> ** 2 ) ** 2
  $
}

sub MAIN(
  $number where * ~~ &date-number,
  --> Nil
) {
  given $0[0] {
    when 1 { .make(19) }
    when 2 { .make(20) }
  }

  Date.new(
    year  => $0[0].made ~ $0[1],
    month => $1[0],
    day   => $1[1],
  ).say;
}
