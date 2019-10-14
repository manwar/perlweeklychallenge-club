perl -E'say map{$a=$_;map{join","," $a",$_,12-$a-$_}$a+1..5.5-$a/2}1..3'
