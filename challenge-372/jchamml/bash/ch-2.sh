perl -e 'for $s(@ARGV){my $l="";for (split //,$s){$s=~m/$_(.*)$_/; if(length($1)>length($l)){ $l=$1;} } print "in $s:$l\n";} ' "aaaaa"  "abcdeba" "abbc" "abcaacbc" "laptop"
