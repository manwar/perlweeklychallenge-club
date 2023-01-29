# tried to do this w a one liner :)
#
perl -E '@a=(1,1,1,1,1,1,1,1);say @a;@o=@a;for($i=2;$i<=scalar(@o);$i++){splice(@a,0,$i,$i);say @a;for(1..$#a){last if $a[$_+1]==undef;splice(@a,$_,2,$a[$_]+$a[$_+1]);@b=@a;if($a[0]>=3 and $b[$_+1]!=undef){splice(@b,$_,2,$b[$_]+$b[$_+1]);say @b};say @a};@a=@o}'


