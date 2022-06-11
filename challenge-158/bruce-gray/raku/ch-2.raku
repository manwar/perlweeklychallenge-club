sub up-thru ( @a, $n ) { gather for @a { $_ <= $n ?? .take !! last } }

constant @cubes  = ^Inf X** 3;
constant @cubans = @cubes.skip Z- @cubes;
constant @cubans_primes = @cubans.grep: &is-prime;

put @cubans_primes.&up-thru(1000).join: ', ';
