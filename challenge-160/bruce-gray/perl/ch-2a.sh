perl -MList::Util=reductions -wE 'die if !@ARGV; my @x = reductions { $a + $b } @ARGV; my @y = reverse reductions { $a + $b } reverse @ARGV; say join ", ", grep { $x[$_] == $y[$_] } keys @x;' $@
