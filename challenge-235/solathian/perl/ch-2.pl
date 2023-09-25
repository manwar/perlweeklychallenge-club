#!usr/bin/perl
use v5.38;

# Challenge 235 - 2 - Duplicate Zeros

dup0(1, 0, 2, 3, 0, 4, 5, 0);       # (1, 0, 0, 2, 3, 0, 0, 4)
dup0(1, 2, 3);                      # (1, 2, 3)
dup0(0, 3, 0, 4, 5);                # (0, 0, 3, 0, 0)


sub dup0(@old)
{

    my @new;
    
    foreach my $elem (@old)
    {
        push(@new, $elem);
        push(@new, $elem)   if($elem == 0);
    }
    splice(@new, @old);     # remove elements after the size
    say join ',', @new;
}