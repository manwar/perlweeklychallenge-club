# !/bin/perl is_factorion.pl NNN

use strict;

sub factorial
    {
    my $fact = 1;
    $fact *= $_ foreach (2..$_[0]);
    $fact;
    }

sub is_factorion
    {
    my ($len, $ord_0, $digfactsum) = (length($_[0]), ord('0'), 0);
    for(my $i=0; $i<$len; $i++) { $digfactsum += factorial(vec($_[0], $i, 8) - $ord_0); }
                                                                           # ^ minus the ascii digits range offset
    (($digfactsum == $_[0])? 1:0);
    }

print is_factorion($ARGV[0]);
