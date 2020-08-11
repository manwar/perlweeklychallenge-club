my @s = $S.comb;
@s[$_, ($_ + $O) % $N] = @s[($_ + $O) % $N, $_] for 1..$C;
say @s.join;
