sub x_matrix {
    for my $row (0 .. $#_) {
    	( ($row==$_ || $row==$#_-$_) ?  $_[$row][$_]
    								 : !$_[$row][$_]
    	) || (return 0) for 0..$#_;
    }
    1
}

sub x_matrix_no_equals {
    my($midpoint,$wor) = ($#_/2,0+@_);
    for my $row (0..$midpoint) {
    	return 0 unless $_[$row][$row] && $_[--$wor][$row] &&
    					$_[$row][$wor] && $_[  $wor][$wor];
    	( $_[$row][$_] || $_[$_][$wor] ||
    	  $_[$wor][$_] || $_[$_][$row] ) && return 0
    	  for $row+1..$wor-1;
    }
    1
}
