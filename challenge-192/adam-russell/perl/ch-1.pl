use v5.36;
##
# You are given a positive integer, $n.
# Write a script to find the binary flip.
##
sub int2bits{
    my($n) = @_;
    my @bits;
    while($n){
        my $b = $n & 1;
        unshift @bits, $b;
        $n = $n >> 1;
    }
    return @bits
}

sub binary_flip{
    my($n) = @_;
    my @bits = int2bits($n);
    @bits = map {$_^ 1} @bits;
    return oct(q/0b/ . join(q//, @bits));
}

MAIN:{
    say binary_flip(5);
    say binary_flip(4);
    say binary_flip(6);
}