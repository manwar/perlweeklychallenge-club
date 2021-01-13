#!/usr/bin/env raku

multi infix:«vs» (Str $v1, Str $v2) {
    my @left  = $v1 ~~ m:g/\d+|\.|_/;
    my @right = $v2 ~~ m:g/\d+|\.|_/;
    $_ = "";
    while @left or @right {
    	my $l = @left.shift  // 0;
    	my $r = @right.shift // 0;
    	next if $l & $r eq '_';
    	if $l eq '_' {
    		$_ = "l"
    	} elsif $r eq '_' {
    		$_ = "r"
    	} elsif $l & $r ~~ /\d/ {
    		if $_ and $l == $r {
    			return $_ eq 'l' ?? -1 !! 1;
    		} else {
    			return  1 if $l > $r;
    			return -1 if $l < $r;
    		}
    	} elsif $l & $r eq '.' {
    		$_ = ''
    	}
    }
    return 0
}
