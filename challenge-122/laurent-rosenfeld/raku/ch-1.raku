use v6;

my @n = 10, 20 ... Inf;
my @cum_moving_avg = @n[0];
for 1..^10 -> $i {
    @cum_moving_avg[$i] = (@cum_moving_avg[$i-1] * $i + @n[$i]) / ($i + 1);
}
say ~@cum_moving_avg;
