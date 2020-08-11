#!/usr/bin/env perl6

sub MAIN(*@files,:$vsort=False) {
	my %data;

	for @files {
		for .IO.lines() {
			%data{$_}++;
		}
	}
	histogram(%data,$vsort,False);
	histogram(%data,$vsort,True);
}

sub histogram(%h,$valueSort,$chart) {
	my @keys=%h.keys.sort;#(*.chars < *.chars);
	my $maxKeyLength=@keys>>.chars.max;
	put "";
	if ($valueSort) {
		@keys=%h.keys.sort(-> $a,$b {%h{$a} < %h{$b}});
	}
	for @keys {
		my $v=%h{$_}.Str;
		$v="#" x %h{$_} if $chart;
		printf("%"~$maxKeyLength~"s| %s\n",$_,$v);
	}
}
