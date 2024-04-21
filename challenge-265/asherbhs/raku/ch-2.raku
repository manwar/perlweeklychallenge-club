sub completing-word(Str:D $str, Str:D @str --> Str:D) {
	my $str-bag = $str.lc.comb.grep(/<[a..z]>/).Bag;
	my @completing = @str.grep($str-bag ⊆ *.comb.Bag);
	@completing ?? @completing.min(*.chars) !! ''
}

say completing-word 'aBc 11c', Array[Str:D].new: 'accbbb', 'abc', 'abbc';
say completing-word 'Da2 abc', Array[Str:D].new: 'abcm', 'baacd', 'abaadc';
say completing-word 'JB 007',  Array[Str:D].new: 'jj', 'bb', 'bjb';
say completing-word 'aBcDeFg', Array[Str:D].new: 'abc', 'bcd', 'cde';
