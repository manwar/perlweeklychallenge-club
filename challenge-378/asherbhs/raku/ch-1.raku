sub second-largest-digit(Str:D $str) {
	my @digits = $str.match(/\d/, :exhaustive)».Int.unique.sort;
	@digits >= 2 ?? @digits[* - 2] !! -1
}

say second-largest-digit 'aaaaa77777';
say second-largest-digit 'abcde';
say second-largest-digit '9zero8eight7seven9';
say second-largest-digit 'xyz9876543210';
say second-largest-digit '4abc4def2ghi8jkl2';
