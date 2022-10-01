use v5.36;

my @default = ( ['a 1 2 b 0', '3 c 4 d'], ['1 2', 'p q r', 's 3', '4 5 t'] );
my @input   = @ARGV ? @ARGV : $default[rand @default]->@*;

say do { local $" = "', '"; "Input:  ['@input']" };

my @digits = map [/([0-9])/g], @input;
my @alphas = map [/([a-z])/g], @input;

my sub str { local $" = ', '; qq/[@{[map @$_ ? "[@$_]" : (), @_]}]/ }
say 'Output: ', str(@digits), ' and ', str(@alphas);
