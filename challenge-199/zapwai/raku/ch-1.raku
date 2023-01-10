my @list = (1,2,3,1,1,3);
#my @list=(1,2,3);
say "Input: (" ~ join(",", @list) ~ ")";
my $cnt = 0 ;
my $str;
loop (my $this = 0; $this < @list.elems - 1; $this++) {
    loop (my $that = $this + 1; $that < @list.elems; $that++) {
	if @list[$this] == @list[$that] {
	    $cnt++;
	    $str ~= "($this, $that)\n";
	}
    }
}
say "Output: $cnt";
say $str if ($str);
