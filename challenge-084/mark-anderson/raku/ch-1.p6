# Raku truncates leading zeros? That's neat.
# I was going to do that manually.

unit sub MAIN($N is copy);

my $sign = $N.sign;

$N = $N.substr(1) if $sign == -1;

$N = $N.flip * $sign;

say $N ~~ -2147483648 .. 2147483647 ?? $N !! 0;
