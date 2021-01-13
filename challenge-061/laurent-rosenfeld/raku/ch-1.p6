use v6;

my @input = @*ARGS;
my @max = @input[0] * @input[1], @input[0], @input[1];
for 1..^@input.end -> $i {
    @max = @input[$i] * @input[$i+1], @input[$i], @input[$i+1]
        if @max[0] < @input[$i] * @input[$i+1];
}
say "Max product is @max[0] for values @max[1] and @max[2]";
