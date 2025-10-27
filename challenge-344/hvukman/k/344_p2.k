prm:{$[0=x;,!0;,/(prm x-1){?[1+x;y;0]}/:\:!x]}
perm:{x[prm[#x]]}
/ returns 0! if no permutation equals target
{target::x;source::y; &1=*/'{x=target}'(,//'perm(source))}[1 2 3 4;((2;3);(1);(4)) ]
{target::x;source::y; &1=*/'{x=target}'(,//'perm(source))}[1 2 3 4;((1;3);(2;4))]
{target::x;source::y; &1=*/'{$[(#x)=#target;x=target;0 ]}'(,//'perm(source))}[5 8 2 9 1;((9;1);(5;8);(2))]
{target::x;source::y; &1=*/'{$[(#x)=#target;x=target;0 ]}'(,//'perm(source))}[1 2 3;((1);(3))]
{target::x;source::y; &1=*/'{x=target}'(,//'perm(source))}[7 4 6;((7;4;6))]
