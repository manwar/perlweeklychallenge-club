sub rearrange-binary-string($str) {
	my $steps = 0;
	my $old;
	my $new = $str;
	repeat {
		$old = $new;
		$new = $old.subst: '01', '10', :g;
		$steps++;
	} while $new ne $old;
	$steps - 1
}

say rearrange-binary-string '111000';
say rearrange-binary-string '00011';
say rearrange-binary-string '01011';
say rearrange-binary-string '010101';
say rearrange-binary-string '00001';
