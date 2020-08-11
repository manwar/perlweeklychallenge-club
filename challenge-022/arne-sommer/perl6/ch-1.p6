my $primes := (1 .. Inf).grep(*.is-prime);

my $sexy-primes := $primes.grep({ ($_ + 6).is-prime });               # [1]

say "{ $_ +1 }: ($sexy-primes[$_],{ $sexy-primes[$_] +6 })" for ^10;  # [2]

