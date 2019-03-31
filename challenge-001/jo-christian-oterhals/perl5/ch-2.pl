print map { "$_\n" } ($_, qw{Fizz Buzz FizzBuzz})[!($_ % 3) + !($_ % 5) * 2 ] for (1..20)


