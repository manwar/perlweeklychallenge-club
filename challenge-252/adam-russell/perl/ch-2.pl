use v5.38;
##
# Given an integer, $n, write a script to find an array containing $n 
# unique integers such that they add up to zero.
##
srand(ord q/TWC/);
sub rand_sum_zero{
    my $n = shift; 
    my @r;
    my $x = int(rand($n * 5)) + 1;   
    return $x, -$x if $n == 2; 
    my $r;   
    {
        $r = int(rand($x - 1)) + 1;   
        $r *= -1 if rand() < 0.5; 
	redo if $x + $r < $n || $x == 0;
	#$r = $x - $r;
    } 
    my $s = $x + $r;
    push @r, $x, $r; 
    while(@r < $n - 1){
        {
	    $r = int(rand($r - 1)) + 1;   
            $r *= -1 if rand() < 0.5; 
	    redo if (0 != grep {$_ == $r} @r) || $s + $r < $n || $x == 0;
	} 
        $s += $r;
        push @r, $r;   
    }
    push @r, -$s if @r == $n - 1; 
    return @r; 
}

sub unique_sum_zero{
    my $n = shift;
    return 0 if $n == 1; 
    return rand_sum_zero $n if $n >= 2; 
}

say join q/,/, unique_sum_zero 1; 
say join q/,/, unique_sum_zero 3; 
say join q/,/, unique_sum_zero 5; 


