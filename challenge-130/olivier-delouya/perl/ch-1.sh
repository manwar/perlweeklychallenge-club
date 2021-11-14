perl -se "@N=eval($N); $hash{$_}++ foreach(@N); foreach(keys %hash) {if($hash{$_} % 2) {print $_; exit; }} ; " -- -N="(2, 5, 4, 4, 5, 5, 2)"

perl -se "@N=eval($N); $hash{$_}++ foreach(@N); foreach(keys %hash) {if($hash{$_} % 2) {print $_; exit; }} ; " -- -N="(1, 2, 3, 4, 3, 2, 1, 4, 4)"
