perl -E 'for(1..20){$x.="Fizz"if!($_%3);$x.="Buzz"if!($_%5);say($x||$_);$x=""}'


