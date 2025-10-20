use v5.38;

sub proc($x, @ints) {
    say "Input: \@ints = @ints, \$x = $x";
    my $num = join '', @ints;
    my $sum = $x + $num;
    my @o = split "", $sum;
    say "Output: @o"; 
}

my $x = 12;
my @ints = (1,2,3,4);
proc($x, @ints);
$x = 181;
@ints = (2,7,4);
proc($x, @ints);
$x = 1;
@ints = (9,9,9);
proc($x, @ints);
$x = 9999;
@ints = (1,0,0,0,0);
proc($x, @ints);
$x = 1000;
@ints = (0);
proc($x, @ints);
