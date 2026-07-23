sub replace-question-mark($str) {
	my $n = $str.comb('?').elems;
	do for ^2**$n {
		my @digits = .base(2).fmt(Q:c[%0{$n}s]).comb;
		$str.subst: '?', {@digits[$++]}, :g
	}
}

say replace-question-mark '01??0';
say replace-question-mark '101';
say replace-question-mark '???';
say replace-question-mark '1?10';
say replace-question-mark '1?1?0';

