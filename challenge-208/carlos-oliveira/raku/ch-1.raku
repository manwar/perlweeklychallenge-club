use Test;

sub minimum-index-sum (Str @array1, Str @array2 --> Hash(Seq)) {	
	return (@array1.pairs X @array2.pairs)
		.grep({ @_[0].value eq @_[1].value })
		.map({ [ @_[0].value, @_[0].key + @_[1].key ] })
		.sort({ @^a[0] cmp @^b[0] || @^a[1] <=> @^b[1] })
		.squish(:as({ @_[0] }))
		.map({ |@_ });
}

is-deeply minimum-index-sum(
	(my Str @ = ["Perl", "Raku", "Love"]),
	(my Str @ = ["Raku", "Perl", "Hate"])
), { Raku => 1, Perl => 1 };

is-deeply minimum-index-sum(
	(my Str @ = ["A", "B", "C"]),
	(my Str @ = ["D", "E", "F"])
), {};

is-deeply minimum-index-sum(
	(my Str @ = ["A", "B", "C"]),
	(my Str @ = ["C", "A", "B"])
), { A => 1, B => 3, C => 2 };

is-deeply minimum-index-sum(
	(my Str @ = ["A", "B", "C", "D"]),
	(my Str @ = ["C", "D", "A", "B", "D"])
), { A => 2, B => 4, C => 2, D => 4 };