use v6;

# Read $n.
my $n = $*IN.get;

# Get divisors of $n from 1 to sqrt($n). If $n is 36 then @d1 is (1, 2, 3, 4, 6).
my @d1 = (1 .. sqrt $n).grep({ $n %% $_ });

# Get divisors of $n from $n down to sqrt($n). If $n is 36 then @d2 is (36, 18, 12, 9, 6).
my @d2 = $n <</<< @d1;

# Add divisors in @d1 and @d2 together. If $n is 36 then @sum is (37, 20, 15, 13, 12).
my @sum = @d1 <<+>> @d2;

# If there are any @sum entries that differ by one print "1", otherwise print "0".
say (@sum.any == @sum.any+1) ?? 1 !! 0;
