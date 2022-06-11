unit sub MAIN(Int $n);
my @A014080 = 1, 2, 145, 40585;

# Seems we have to coerce the argument $n into a number first by multiplying by
# 1. Didn't expect that.
say $n*1 ∈ @A014080;