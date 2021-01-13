perl -E '$xcol="A"; for (1..16384) {$xcol_num{$xcol}=$_; $num_xcol{$_}=$xcol; $xcol++}; say /\d+/ ? $num_xcol{$_} : $xcol_num{$_} for (shift)'
