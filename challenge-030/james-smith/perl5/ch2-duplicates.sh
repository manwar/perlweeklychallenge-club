perl -E'say map{$a=$_;map{" $a,$_,".(12-$a-$_)}$a..6-$a/2}1..4'
