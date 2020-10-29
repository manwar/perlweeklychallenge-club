use v6;

constant $max = 2 ** 31 - 1; # i.e. 2_147_483_647

my $input = @*ARGS[0] // 1234;
my $positive = True;
if $input < 0 {
    $positive = False;
    $input = -$input;
}
my $output = $input.flip;
$output = 0 if $positive and $output >= $max;
$output = 0 if $output >= $max + 1; # 32-bit negative numbers can go up to 2 ** 31
# No specification for inputs ending with 0
# We numify $output and negate it if needed
$output = $positive ?? +$output !! -$output;
say $output;
