#!/usr/bin/env raku
use Test;

=begin early-bird

# Solution to the original early bird club problem

is-deeply stc(6,5,4,8),     (2,1,0,3);
is-deeply stc(7,7,7,7),     (0,0,0,0);
is-deeply stc(5,4,3,2,1),   (4,3,2,1,0);
is-deeply stc(-1,0,3,-2,1), (1,2,4,0,3);
is-deeply stc(0,1,1,2,0),   (0,2,2,4,0);

sub stc(+@nums)
{
    my %bag is Bag = @nums; 
    my @keys = %bag.keys.sort;
    my %map is Map = @keys Z=> [\+] 0, |%bag{@keys};
    %map{@nums}
}

=end early-bird 

is-deeply stc([6,5,4,8]),     (2,1,0,3);
is-deeply stc([7,7,7,7]),     (3,3,3,3);
is-deeply stc([5,4,3,2,1]),   (4,3,2,1,0);
is-deeply stc([-1,0,3,-2,1]), (1,2,4,0,3);
is-deeply stc([0,1,1,2,0]),   (1,3,3,4,1);

# 500 numbers
my @a = (0..99,300..399,500..599,700..799,900..999).flat;  

# 1,000,000 random numbers from the above list
@a .= roll(1e6); 

# ~ 1.2 seconds on my computer 
stc(@a);

sub stc(@nums)
{
    my %bag is Bag = @nums; 
    my @keys = %bag.keys.sort;
    my %map is Map = @keys Z=> ([\+] %bag{@keys}) >>->> 1;
    %map{@nums}
}
