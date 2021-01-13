use v6;

my @a = 10, 20, 30, 40, 50;
my @indices = 3, 4;

say "Input array: ", @a;
for @indices -> $i {
    my @out = @a[($i..@a.end, 0..$i -1).flat];
    say @out;
}
