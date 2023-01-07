my @list = (2,5,8,1);
#my @list = (3);
say "Input: (" ~ join(",",@list) ~ ')';
@list = sort @list;
my $gap = 0;
loop (my $i = 0; $i < @list.elems - 1; $i++) {
    my $diff = @list[$i + 1] - @list[$i];
    $gap = $diff   if ($gap < $diff );
}
my $cnt = 0;
my @ind;
loop ($i = 0; $i < @list.elems - 1; $i++) {
    my $diff = @list[$i + 1] - @list[$i];    
    if $gap == $diff {
	$cnt++ ;
	@ind.push($i);
    }
}

say "Output: $cnt";
unless ($cnt == 0) {
    print "The sorted list " ~ @list ~ " contains: ";
    for (@ind) {
	print "(" ~ @list[$_] ~ "," ~ @list[$_+1] ~ ")"; 
    }
    say "";
}
