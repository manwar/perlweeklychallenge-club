#!/usr/bin/env raku

say (1..*).grep(&happy-number).head(8);

sub happy-number($n is copy)
{
    my $cycle := 4, 16, 37, 58, 89, 145, 42, 20;

    loop
    {
        return True  if $n == 1;
        return False if $n (elem) $cycle;
        $n = [+] $n.comb >>**>> 2; 
    }
}
