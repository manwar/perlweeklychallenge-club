#!/usr/bin/env raku
my $matrix=[
	[ 1, 2, 3 ],
	[ 4, 5, 6 ],
	[ 7, 8, 9 ]
];

say "0deg rotation:";
rotate($matrix,0);
say "90deg rotation:";
rotate($matrix,90);
say "180deg rotation:";
rotate($matrix,180);
say "270deg rotation:";
rotate($matrix,270);

sub rotate($input,$angle) {
	#input indexing
	my @ip= map {pi/4 *$_}, 0..7;
	my @ir= map {1+round .sin}, @ip;	#no sincos func in raku?
	my @ic= map {1+round .cos}, @ip;	#.. feature request!

	#output indexing
	my @polar=map {($angle/180 *pi) + pi/4 *$_}, 0..7;
	my @row= map {1+round .sin}, @polar;
	my @col =map {1+round .cos}, @polar;

	my $out=[[],[],[]];

	$out[1][1]=$matrix[1][1];
	$out[@row[$_]][@col[$_]]=$matrix[@ir[$_]][@ic[$_]] for (0..^@col);
	say "["~join(", ", $out[$_])~"]" for 0..2;
	$out;
}
