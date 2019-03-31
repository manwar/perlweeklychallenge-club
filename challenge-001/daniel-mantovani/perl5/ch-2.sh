perl -E 'say {0 => $_, 1 => "fizz", 2 => "buzz", 3 => "fizz buzz"}->{!($_ % 3) + 2 * !($_ % 5)} for 1..20'

