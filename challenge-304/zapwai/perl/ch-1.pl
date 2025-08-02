use v5.38;

sub proc($n, @dig) {
    say "Input: \@dig = @dig, \$n = $n";
    my $num_ones = grep {$_ == 1} @dig;
    print "Output: ";
    my $cap = (@dig % 2 == 0) ? @dig / 2 : 1 + @dig / 2;
    ($n + $num_ones <= $cap) ? say "true" : say "false";
}

my @dig = (1,0,0,0,1);
my $n = 1;
proc($n, @dig);
@dig = (1,0,0,0,1);
$n = 2;
proc($n, @dig);
@dig = (1,0,0,0,0,1);
$n = 1;
proc($n, @dig);
