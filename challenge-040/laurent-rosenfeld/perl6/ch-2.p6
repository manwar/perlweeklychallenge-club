use v6;

my @numbers = 10, 4, 1, 8, 12, 3;
my @indices = 0, 2, 5;

@numbers[@indices] = sort @numbers[@indices];
say @numbers;
