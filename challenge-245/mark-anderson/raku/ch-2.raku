#!/usr/bin/env raku
use Test;

# With help from https://www.geeksforgeeks.org/find-largest-multiple-3-array-digits-set-2-time-o1-space/

is largest-of-three(8,1,9),     981;
is largest-of-three(8,6,7,1,0), 8760;
is largest-of-three(1),         Nil;

sub largest-of-three(*@n)
{
    @n .= sort(-*);

    given @n.sum mod 3
    {
        when 0
        {
            return [~] @n
        }

        when 1
        {
            my $i = @n.first(* % 3 == 1, :k:end);
            
            with $i 
            { 
                @n.splice($i, 1);
                return @n.head ?? [~] @n !! Nil 
            }

            else 
            { 
                return Nil 
            }
        }

        when 2
        {
            my $i = @n.first(* % 3 == 2, :k:end);

            with $i
            {
                @n.splice($i, 1);
                return @n.head ?? [~] @n !! Nil 
            }

            else
            {
                for (^2)
                {
                    my $i = @n.first(* % 3 == 1, :k:end);
                    
                    with $i
                    {
                        @n.splice($i, 1);
                    }

                    else
                    {
                        return Nil
                    }
                }
                 
                return @n.head ?? [~] @n !! Nil 
            }   
        }
    }
}
