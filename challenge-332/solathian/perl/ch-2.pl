use v5.40;
use List::Util qw(all);

isOdd("weekly");    # false
isOdd("challenge"); # false
isOdd("perl");      # true
isOdd("perl112");   # true
isOdd("");   # true



sub isOdd($string)
{
    my %hash;
    
    $string =~ s/[^a-z]//gi;    # remove everything which is not between 'a' and 'z', since it only mentioned letters
    $hash{$_}++ foreach (split('', $string));
    ((all{$_ % 2 != 0} values %hash) and (scalar values %hash > 0)) ? say 'true' : say 'false';
}

