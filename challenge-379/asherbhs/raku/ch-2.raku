sub armstrong-number(Int:D $base, Int:D $limit --> Seq:D) {
	(0 ..^ $limit).grep: {
		my $digits = .polymod: $base xx *;
		$_ == [+] $digits »**» +$digits
	}
}

say armstrong-number(10, 1000);
say armstrong-number(7,  1000);
say armstrong-number(16, 1000);
