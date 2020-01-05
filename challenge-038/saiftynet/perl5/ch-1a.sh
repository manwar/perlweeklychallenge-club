perl -MTime::Local -le ' print "".($1==1?19:20).$2."-$3-$4" if (shift=~/^(1|2)(\d{2})(\d{2})(\d{2})$/  and  timelocal( 0, 0, 0, $4, $3-1, ($1==1?19:20).$2));print "error in input" if (!$1) ;' 1241112
