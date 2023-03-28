#!/usr/bin/perl

# Challenge 210
#
# Task 2: Number Collision
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers which can move in right direction if it is
# positive and left direction when negative. If two numbers collide then the
# smaller one will explode. And if both are same then they both explode. We
# take the absolute value in consideration when comparing.
#
# All numbers move at the same speed, therefore any 2 numbers moving in the same
# direction will never collide.
#
# Write a script to find out who survives the collision.
# Example 1:
#
# Input: @list = (2, 3, -1)
# Output: (2, 3)
#
# The numbers 3 and -1 collide and -1 explodes in the end. So we are left
# with (2, 3).
#
# Example 2:
#
# Input: @list = (3, 2, -4)
# Output: (-4)
#
# The numbers 2 and -4 collide and 2 explodes in the end. That gives us (3, -4).
# Now the numbers 3 and -4 collide and 3 explodes. Finally we are left with -4.
#
# Example 3:
#
# Input: @list = (1, -1)
# Output: ()
#
# The numbers 1 and -1 both collide and explode. Nothing left in the end.

use Modern::Perl;

sub find_collision {
    my(@n)=@_;
    for my $i (0..$#n-1) {
        if ($n[$i]>0 && $n[$i+1]<0 ||
            $n[$i]<0 && $n[$i+1]>0) {
            return $i;
        }
    }
    return -1;
}

sub number_collision {
    my(@n)=@_;
    my $i;
    while (($i=find_collision(@n))>=0) {
        if (abs($n[$i])==abs($n[$i+1])) {
            splice(@n,$i,2);            # both explode
        }
        elsif (abs($n[$i])>abs($n[$i+1])) {
            splice(@n,$i+1,1);          # right explodes
        }
        elsif (abs($n[$i])<abs($n[$i+1])) {
            splice(@n,$i,1);            # left explodes
        }
        else { die; }
    }
    return @n;
}

@ARGV or die "usage: ch-2.pl nums...\n";
my @n=@ARGV;
@n=number_collision(@n);
say "(",join(", ", @n),")";
