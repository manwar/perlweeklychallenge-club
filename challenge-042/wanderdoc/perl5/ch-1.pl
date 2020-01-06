#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to print decimal number 0 to 50 in Octal Number System.

For example:
Decimal 0 = Octal 0
...
Decimal 7 = Octal 7
Decimal 8 = Octal 10

and so on.
=cut



for my $number ( 0 .. 50 )
{
     print join(' = ', join(' ', 'Decimal', $number),
                       join(' ', 'Octal', sprintf("%o", $number))), $/;  
}