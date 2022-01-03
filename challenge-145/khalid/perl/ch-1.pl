sub dotprod
{
        my($vec_a, $vec_b) = @_;
        die "Vector size must be same \n" unless @$vec_a == @$vec_b;
        my $sum = 0;
        $sum += $vec_a->[$_] * $vec_b->[$_] for 0..$#$vec_a;
        return $sum;
}
 
my @vec_a = (1,2,3);
my @vec_b = (4,5,6);
 
print dotprod(\@vec_a,\@vec_b), "\n";