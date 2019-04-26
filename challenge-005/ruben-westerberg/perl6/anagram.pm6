unit module anagram;

sub findAnangrams(@letters, @words) is export {
	my @a=sort @letters;
	my @anagrams;
	my $test;
	while * {
		my $k=0;
		my $l=0;
		my $tmp;
		my $flag=False;
		my $maxK=-1;
		my $maxL=-1;
		
		while ($k < @a.elems-1) {
			$maxK= $k if ((@a[$k] lt @a[$k+1]) && ($k > $maxK));
			$k++;
		}
		last unless $maxK >= 0;
		$maxL=$maxK+1;
		while ($l < @a.elems) {
			$maxL= $l if ((@a[$maxK] lt @a[$l]) && $l>$maxL);
			$l++;
		}
		$tmp=@a[$maxK];
		@a[$maxK]=@a[$maxL];
		@a[$maxL]=$tmp;
		my @b=@a.splice($maxK+1).reverse;
		@a.=append(@b);
		$test=@a.join("");
		#say  $test;
		@anagrams.append(@words.hyper(degree=>4,batch=>50000).grep: {$_ eq $test});
		
	}
	$test=@a.join("");
	@anagrams.append(@words.hyper(degree=>4,batch=>50000).grep: {$_ eq $test});
	@anagrams;
}
