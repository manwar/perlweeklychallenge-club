# Variable names are from https://mathworld.wolfram.com/FortunatePrime.html

sub first-prime-greater-than ( UInt $n ) { return first &is-prime, $n ^.. * }

constant @primes  = grep &is-prime, ^Inf;               # https://oeis.org/A000040

constant @Ek = map { $^product + 1 }, [\*] @primes;     # https://oeis.org/A006862

constant @Qk = @Ek.map: &first-prime-greater-than;      # https://oeis.org/A035345

constant @Fk = (@Qk Z- @Ek) X+ 1;                       # https://oeis.org/A005235

# https://oeis.org/A046066
# Fortunate primes (A005235) in numerical order with duplicates removed. 
my $count = first { @Fk.head($_).unique.elems >= 8 }, 1..*;
say @Fk.head($count).sort.squish;
