sub greatest-english-letter(Str:D $str --> Str:D) {
	max $str
		.comb
		.classify(* ∈ 'A' .. 'Z', as => *.uc)
		.values
		.reduce(&[∩])
		.keys
		|| ''
}

say greatest-english-letter 'PeRlwEeKLy';
say greatest-english-letter 'ChaLlenge';
say greatest-english-letter 'The';
