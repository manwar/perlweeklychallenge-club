subset IntArray of Array where .all ~~ Int;

subset NonEmptyIntArray of IntArray where .elems > 0;

unit sub MAIN(*@integers where * ~~ NonEmptyIntArray);

my $bag = bag @integers;

my ($k, $v) = $bag.maxpairs.first.kv;

my $t = $bag.total;

if $v <= $t div 2 { 
    say "-1 as none of the elements appears more than floor($t/2)."  
} 

else { 
    my $s = do if $v == 1 { q{} } else { "s" }

    say "$k, as $k appears $v time$s in the list which is more than floor($t/2)."
}
