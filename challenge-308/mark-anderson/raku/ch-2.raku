#!/usr/bin/env raku
use Test;

is-deeply decode-xor([1,2,3],   1), (1,0,2,1);
is-deeply decode-xor([6,2,7,3], 4), (4,2,0,7,4);

sub decode-xor(@e, $i)
{
    my $c;
    ($i, $i+^@e[$c++], {$^a+^@e[$c++]}...*).head(@e+1)
}

=begin alternate-solution
sub decode-xor(@encoded, $initial is copy)
{
    gather for @encoded
    {
        once take $initial;
        take $initial +^= $_    
    }
}
=end alternate-solution
