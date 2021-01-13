#!/usr/bin/env raku
my $f={sprintf "%02d%02d%04d", .month,.day,.year};
put (Date.new("2000-01-01",formatter=>$f)..Date.new("2999-01-01"))
	.grep({my $str= .Str;$str.flip eq $str})
	.map({ "Date is a palindrone: "~Date.new($_)~"\n"}).join;

