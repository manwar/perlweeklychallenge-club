use v5.38;

sub product_sign{
    my @z = grep { $_ == 0 } @_;
    return 0 if @z > 0; 
    my @n = grep { $_ < 1 } @_;
    return 1 if @n % 2 == 0;
    return -1 if @n >= 1; 
    return 1; 
}






my @ints;
@ints = (-1, -2, -3, -4, 3, 2, 1);  
say product_sign @ints;
@ints = (1, 2, 0, -2, -1);  
say product_sign @ints;
@ints = (-1, -1, 1, -1, 2);  
say product_sign @ints;
