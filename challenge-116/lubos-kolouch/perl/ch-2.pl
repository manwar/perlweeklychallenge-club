sub sum_of_squares {
    my ($n) = @_;
    
    my $sum = 0;
    while($n){
        my $digit = $n % 10;
        $sum += $digit * $digit;
        $n = int($n/10);
    }
    
    my $sqrt = int(sqrt($sum));
    if($sqrt * $sqrt == $sum){
        return 1;
    } else {
        return 0;
    }
}

print sum_of_squares(34), "\n"; # Prints 1
print sum_of_squares(50), "\n"; # Prints 1
print sum_of_squares(52), "\n"; # Prints 0

