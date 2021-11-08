#!/usr/bin/env raku

use Test;
plan 9;

is next-palindrome-number(3),                                             4;
is next-palindrome-number(9),                                            11;
is next-palindrome-number(999),                                        1001;
is next-palindrome-number(1234),                                       1331;
is next-palindrome-number(1999),                                       2002;
is next-palindrome-number(4321),                                       4334;
is next-palindrome-number(4444),                                       4554;
is next-palindrome-number(500006),                                   501105;
is next-palindrome-number(90000056780000000000000), 90000056780008765000009; 

multi next-palindrome-number($N where * == 9) { 11 } 

multi next-palindrome-number($N)
{
    my ($left, $middle) = partition($N);
    my $next = $left ~ $middle ~ $left.flip;

    while $next <= $N
    {
        $next = ($left ~ $middle) + 1;
        $next ~= $next.substr(^$left.chars).flip;
    }

    $next;
}

sub partition($N)
{    
    my @left   = $N.comb;
    my $middle = q{};
    my @right  = @left.splice(+@left div 2);

    if @left < @right
    {
        $middle = @right.shift;
    }

    @left.join, $middle;
}
