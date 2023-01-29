use Test;

sub missing-numbers (Int:D @numbers --> Set:D[Int:D]) {
  return ((0..@numbers) (-) @numbers);
}

is-deeply missing-numbers(my Int @ = 0,1,3),     Set.new(2);
is-deeply missing-numbers(my Int @ = 0,1),       Set.new(2);
is-deeply missing-numbers(my Int @ = 0,5,5,4,5), Set.new(1,2,3);
