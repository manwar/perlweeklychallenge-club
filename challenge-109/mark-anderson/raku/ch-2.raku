#!/usr/bin/env raku

say four-squares(1..7)[4];

sub four-squares(@input)
{
    my @chars = "a".."g";

    gather
    {
        for @input.permutations -> @perm 
        {
            my $m = Map.new(@chars Z=> @perm);
            my ($a, $b, $c, $d, $e, $f, $g) = @perm;

            if $a + $b == $b + $c + $d == $d + $e + $f == $f + $g 
            {
                take chomp qq:to/END/;
                @chars.map({ "$_ = $m{$_}" }).join("\n") 

                Box 1: a + b = $a + $b = { $a + $b }
                Box 2: b + c + d = $b + $c + $d = { $b + $c + $d }
                Box 3: d + e + f = $d + $e + $f = { $d + $e + $f }
                Box 4: f + g = $f + $g = { $f + $g }
                END
            }
        }
    }
}
