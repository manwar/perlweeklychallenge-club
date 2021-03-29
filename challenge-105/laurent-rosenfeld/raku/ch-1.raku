use v6;

my $input = @*ARGS[0] // 248832;
for 1..10 -> $i {
    printf "%2i\t%10.3f\n", $i, $input ** (1/$i);
}
