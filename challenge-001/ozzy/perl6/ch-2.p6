use v6;

for 1..20 -> $x { say ( $x %% 3 && $x %% 5 ?? "FizzBuzz" !! ( $x %% 3 ?? "Fizz" !! ( $x %% 5 ?? "Buzz" !! $x ) ) ) };


