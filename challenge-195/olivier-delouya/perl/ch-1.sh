WC192_1='@list = eval($list); $min = -1; foreach(@list) { $min = $_ if(!($_ & 1) && ($min == -1 || $_ < $min)); }; print $min;'

perl -se "$WC192_1" -- -list="(1,1,2,6,2)"
perl -se "$WC192_1" -- -list="(1,3,5,7)"
perl -se "$WC192_1" -- -list="(6,4,4,6,1)"
