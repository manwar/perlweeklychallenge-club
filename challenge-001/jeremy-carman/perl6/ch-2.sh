perl6 -e 'sub fb($n) { ($n % 3 == 0 and $n % 5 == 0) ?? "FizzBuzz" !! $n
% 3 == 0 ?? "Fizz" !! $n % 5 == 0 ?? "Buzz" !! $n }; say map &fb, 1..20'

