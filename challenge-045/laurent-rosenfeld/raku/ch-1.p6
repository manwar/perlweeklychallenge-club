use v6;

my $msg = @*ARGS ?? shift @*ARGS
    !! "The quick brown fox jumps over the lazy dog";
$msg ~~ s:g/\s+//;
my @letters = map { ~ $_}, $msg ~~ m:g/ .**1..8/;
for 0..7 -> $i {
    print " ", join "", map { substr  $_, $i, 1 if .chars >= $i}, @letters;
}
