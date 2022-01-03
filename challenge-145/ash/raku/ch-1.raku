my @a = 1, 2, 3;
my @b = 4, 5, 6;

my $scalar = [+](@a Z* @b);
say $scalar;
