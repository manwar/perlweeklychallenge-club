#!/usr/bin/env perl6
use MONKEY-SEE-NO-EVAL;
my $string="123456789";
put "Input string to split and combine to 100: $string";
my @digits=$string.comb;
my $i=0;
my $limit="100000000".parse-base(3);
for $i..$limit {
	my $num= .base(3).fmt("%08s0");
	my $exp=(@digits Z $num.comb.map({TR:d/120/+-/.Str;})).flat.join: "";
	my $sum=EVAL $exp;
	put "sum: $sum from $exp" if $sum==100;
}

