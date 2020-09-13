unit sub MAIN($f);
my @i=$f.IO.lines.map:{.comb};
sub a($m,$x,$y){my &n={$m[$x+.[0];$y+.[1]] andthen $_ eq "X"}
!((-1,-1),(-1,0),(-1,1),(0,-1),(0, 1),(1,-1),(1,0),(1,1)).grep: &n}
dd (^@i X ^@i.head).grep(->($x,$y){@i[$x;$y] eq "X" && @i.&a($x,$y)})