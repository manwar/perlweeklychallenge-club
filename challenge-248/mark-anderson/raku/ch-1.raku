#!/usr/bin/env raku
use Test;

is-deeply shortest-distance("loveleetcode", "e"), (3,2,1,0,1,0,0,1,2,2,1,0);
is-deeply shortest-distance("aaab", "b"),         (3,2,1,0);
is-deeply shortest-distance("eabcde", "e"),       (0,1,2,2,1,0);
is-deeply shortest-distance("eabcdf", "e"),       (0,1,2,3,4,5);
is-deeply shortest-distance("abecd", "e"),        (2,1,0,1,2);
is-deeply shortest-distance("abcefg", "e"),       (3,2,1,0,1,2);
is-deeply shortest-distance("eeeabecefeeg", "e"), (0,0,0,1,1,0,1,0,1,0,0,1);

sub shortest-distance($str, $char)
{
    my @a = $str.split(/<$char>+/, :v);

    my $head = @a.shift;
    $_ = .chars ?? (.chars...1) !! Empty given $head;

    my $tail = @a.pop;
    $_ = .chars ?? (1....chars) !! Empty given $tail;

    @a.push: ~Empty;

    my $middle = gather for @a -> $a, $b
    {
        take 0 xx $a.chars; 
        take distances($b)
    }

    flat ($head, $middle, $tail)>>.List
}
        
sub distances($s)
{
    return Empty unless $s;
    my $mid = ($s.chars / 2).ceiling; 
    my @r = (1...^$mid), ($mid, $mid), ($mid^...1);
    @r[1] .= squish unless $s.chars %% 2;
    @r.List
}

# sub shortest-distance-check($str, $char)
# {
#     my @zeros = $str.indices($char);
#     (^$str.chars).map(-> $k { min @zeros.map({ abs($_ - $k) }) })
# }
