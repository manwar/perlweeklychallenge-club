use v6;

my @a = 1, 2, 3;
my @b = 4, 5, 6;

say sum @a Z* @b;  # Could also be: say [+] @a Z* @b;
