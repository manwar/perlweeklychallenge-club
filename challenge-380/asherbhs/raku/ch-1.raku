sub sum-of-frequencies(Str:D $str) {
	$str
		.comb.classify(* ∈ <a e i o u>).values # split into vowels and consonants
		.map(*.classify(*).values».elems.max)  # count of most frequent in each
		.sum
}

say sum-of-frequencies 'banana';
say sum-of-frequencies 'teestett';
say sum-of-frequencies 'aeiouuaa';
say sum-of-frequencies 'rhythm';
say sum-of-frequencies 'x';
