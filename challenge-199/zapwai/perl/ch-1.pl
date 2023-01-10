use v5.30.0;
my @list = (1,2,3,1,1,3);
#my @list =(1,2,3);
my $cnt = 0;
my $str;
for my $this (0 .. $#list - 1) {
    for my $that ($this + 1 .. $#list) {
	if ($list[$this] == $list[$that]) {	    
	    $str .= "($this, $that)\n";
	    $cnt++;
	}
    }
}
say "Input: (". join(",",@list).")";
say "Output: $cnt";
chomp $str;
say $str;
