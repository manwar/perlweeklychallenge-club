use v6;

my @input = 2, 9, 3, 5;
my @sorted = sort @input;
my $max = 0;
for 1..@sorted.end -> $i {
    $max = @sorted[$i] - @sorted[$i-1] if @sorted[$i] - @sorted[$i-1] > $max;
}
say "Max gap: $max";
