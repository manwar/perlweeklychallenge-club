my $a = '1234';
my $b = '5678';

my $L = 51;

my @fib = $a, $b, * ~ * ... *;

my $long = @fib.first: *.chars >= $L;
my $char = $long.comb[$L-1];

say "The {$L}st digit in the first term having at least $L digits '$long' is $char."; 
