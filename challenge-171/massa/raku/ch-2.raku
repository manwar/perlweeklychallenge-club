use v6;
my sub compose(Code $a, Code $b) {
  -> |arguments { $a.(|$b.(|arguments)) }
}

sub plusminus(\a, \b) {
  return a + b, a - b
}

sub multdiv(\a, \b) {
  return a * b, a / b
}

my $x = compose &plusminus, &multdiv;

plusminus(|multdiv(3, 8)).raku.say;
$x.(3, 8).raku.say;

compose({ $^a + $^b }, &multdiv).(3, 8).raku.say;
