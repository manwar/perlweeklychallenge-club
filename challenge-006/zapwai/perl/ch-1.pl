my @list = (1,2,3,4,9,10,14,15,16,20);
my $str;
my $flag = 0;
my $begin;
for (0 .. $#list - 1) {
    if ($list[$_ + 1] == 1 + $list[$_]) {
	if ($list[$_ + 2] == 1 + $list[$_ + 1] ) {
	    $begin = $list[$_] unless ($flag);
	    $flag = 1;
	}
	$str .= "$list[$_]," unless ($flag);	
    }
    if (($list[$_ + 1] != 1 + $list[$_]) or ($_ + 1 == $#list)) {
	$str .= "$list[$_]," unless ($flag);
	if ($flag) {
	    $flag = 0;
	    $str .= "$begin-$list[$_],";
	}
    }
}
if ($list[$#list-1] + 1 == $list[$#list]) {
    $str =~ s/$list[$#list-1]/$list[$#list]/;
} else {
    $str .= "$list[$#list],";
}
$str = substr $str, 0, -1;
print $str."\n";
