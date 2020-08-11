my $variable = "\$" ~ @*ARGS[0];
my $value = @*ARGS[1]; 
spurt "Temp.pm6", "unit module Temp; my $variable = $value; say \"The value of \\$variable is $variable.\"";
use lib ".";
require Temp;
unlink "Temp.pm6";
