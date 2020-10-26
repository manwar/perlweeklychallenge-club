# Raku truncates leading zeros? That's neat.
# I was going to do that manually :-)

unit sub MAIN(Int $N is copy);

$N = $N.abs.flip * $N.sign;

say $N ~~ -2147483648 .. 2147483647 ?? $N !! 0;
