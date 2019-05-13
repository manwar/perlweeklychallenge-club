#!/usr/bin/env perl6
#
#word ladder
#read arguments, first is start word second is end word
die "Need three arguments, start and end words" if @*ARGS.elems != 3;
my ($start,$end, $wordFileName)=@*ARGS[0..2];
$start.=lc;
$end.=lc;
die "Words not the same length: Ladder ()"  unless ($start.chars == $end.chars);

my @words=($wordFileName.IO.lines.grep({.chars == $start.chars})>>.&{.lc.comb.cache});

die  "Start not in dictionary: Ladder ()" unless (grep $start, @words>>.join);
die "End not in dictionary: Ladder ()" unless (grep $end, @words>>.join);

my @start=$start.comb;
my @end=$end.comb;
my @transforms;
my $found=False;
my $result;
@transforms.push: {w=>@start , p=>Any};
my @seen.push: @start;


my @c=@start;
my $i=0;
while @transforms !== 0 {
	my $e=@transforms.shift;
	my $c=$e<w>;
	say "Itertion: $i, Queue Length: "~ @transforms.elems~ " Current word: $c";
	#exit if $c ~~ <h e r m> && @transforms !==0;
	$result=$e;
	last if $c ~~ @end;
	
	@words.map(-> $d {
		if (($d >>eq<< $c).sum == ($c-1)) && (@seen.grep($d) == 0) {
			@seen.push: $d;
			@transforms.push: (w=>$d, p=>$e).Hash;
		}
	});
	$i++;
}
if $result {
	say "Ladder: ("~pathFromParent($result,$start)~")";
}
else {
	say "No ladder found: Ladder: ()";
}

sub pathFromParent($node, $word) {
	my @path;
	my $parent=$node;
	while ($parent) {
		@path.push: $parent<w>.join;
		last if $parent<w>.join eq $word.join;
		$parent=$parent<p>;
	}
	@path.reverse;
}
