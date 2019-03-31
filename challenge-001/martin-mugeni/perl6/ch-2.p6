# Challenge 2 One liner FizzBuzz

say 'fizz'x!($_ % 3) ~  'buzz'x!($_ % 5) || 'fizzbuzz'x!($_ % 15) || $_, "\n" for 1 .. 20;
