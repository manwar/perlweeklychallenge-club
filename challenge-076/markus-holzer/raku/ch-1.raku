my $N = 1528;

my @primes = (2..^$N)
    .grep( *.is-prime );

my @candidates = @primes X @primes;

my @solutions = @candidates
    .grep( *.sum == $N )
    .map( *.sort.cache )
    .unique( with => &[~~] );

.say for @solutions;