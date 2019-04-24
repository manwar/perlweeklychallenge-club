#!/usr/bin/env perl6
#
my $words-list-file="words_alpha";
my $word-list-url="https://github.com/dwyl/english-words/blob/master/words_alpha.zip?raw=true";

my $res=qqx{curl -L $word-list-url > $words-list-file.zip && unzip $words-list-file.zip } unless ($words-list-file~".txt").IO.e;

my @word-list=($words-list-file~".txt").IO.lines>>.trim;

my $input;
while $input=prompt "Give me a word: " {
	#say grep {$_ eq $input} ,@word-list;
	my @letters=$input.split("")[1..*-2];
	findAnangram(@letters);
}

sub findAnangram(@letters) {
	say "Base word is: @letters[]";
	my @a=sort @letters;
	my @anagrams;#=gather {
	while * {
		my $k=0;
		my $l=0;
		my $tmp;
		my $flag=False;
		my $maxK=-1;
		my $maxL=-1;
		while ($k < @a.elems-1) {
			$maxK=$k if ((@a[$k] lt @a[$k+1]) && ($k > $maxK));
			$k++;
		}
		last unless $maxK >= 0;
		#say  "k is $maxK";
		$maxL=$maxK+1;
		while ($l < @a.elems) {
			$maxL= $l if ((@a[$maxK] lt @a[$l]) && $l>$maxL);
			$l++;
		}
		#say  "l is $maxL";
		$tmp=@a[$maxK];
		@a[$maxK]=@a[$maxL];
		@a[$maxL]=$tmp;
		#say @a;
		my @b=@a.splice($maxK+1).reverse;
		#say @b;
		@a.=append(@b);
		#rest the terminal line here
		#say @a;
		my $test=@a.join("");
		@word-list.hyper.map: {@anagrams.push: $_ if $_ eq $test};
		
	}
	say @anagrams;
}



