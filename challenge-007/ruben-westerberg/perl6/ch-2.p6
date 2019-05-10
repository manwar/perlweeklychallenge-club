#!/usr/bin/env perl6
#
#word ladder
#read arguments, first is start word second is end word
die "Need three arguments, start and end words" if @*ARGS.elems != 3;
my ($start,$end, $wordFileName)=@*ARGS[0..2];

my @words=$wordFileName.IO.lines.grep({.chars == $start.chars});
unless $start.chars == $end.chars && @words.grep( { $_ eq all ($start, $end)} ) {
	say ((););
}

say "Testing against @words.elems()";
my @seen;
my $s={word=>$start,parent=>Any};
#my $node=transforms($start,$s);
my @transforms;
my $found=False;
my $result;
@transforms.push: $s;
while @transforms > 0 && !$found {
	my $current= @transforms.shift;
	#make new transforms

	@seen.push($current<word>);
	my @toAdd=transforms($current);
	#say @toAdd;
	@transforms.append: @toAdd;
	#say @transforms.elems;

}
#say $result;
say pathFromParent($result, $start);
	

#read word list from file and filter by word length
sub transforms($parent is rw) {
	my $word=$parent<word>;
	#@seen.push($word) ;
	#my $node={:$word, parent=>$parent};
	#say $word;
	$found = $word eq $end;
	$result=$parent if ($word eq $end) && (! so $result);

	return if $found;

	my @c=$word.comb;
	constant @letters="a".."z";

	#say $word;
	my @transforms=gather {
		for ^@c -> $c {
			for  @letters -> $l {
				my @tmp=@c;
				@tmp[$c]=$l; 
				my $w=@tmp.join;
				if ( @seen.grep($w) == 0) {
#				say $w;

					take {word=>$w, parent=>$parent};
				}
			}
		}
	}
	@transforms;
}
	
sub pathFromParent($node, $word) {
	my @path;
	my $parent=$node;
	while ($parent) {
		@path.push: $parent<word>;
		last if $parent<word> eq $word;
		$parent=$parent<parent>;
	}
	@path.reverse;
}


