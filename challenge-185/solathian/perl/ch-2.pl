#!usr/bin/perl -w
use strict;
use warnings;

use feature ('say', 'signatures');
no  warnings 'experimental';

# Challange 185 - 2 - Mask Code
# You are given a list of codes in many random format.
# Write a script to mask first four characters (a-z,0-9) and keep the rest as it is.


# my @testlist = ('ab-cde-123', '123.abc.420', '3abc-0010.xy');  # Output: ('xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy')
# my @testlist = ('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f');      # Output: ('xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f')
# maskCode(@testlist);

sub maskCode(@list)
{
    foreach my $string (@list)
    {
        my @characters = split('', $string);
        my $swaps = 0;
        
        foreach my $char (@characters)
        {
            if( $char =~ /[a-z0-9]/)
            {
                $char = 'x';
                $swaps++;
            }

            last if($swaps == 4);
        }
        
        $string = join('', @characters);
    }
 
    say join(', ', @list);
}