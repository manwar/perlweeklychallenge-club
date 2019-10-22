#!/usr/bin/env perl6
my %s;
for (2,4,6,8,10) {
	my $e=$_;
	my $r=12-$e;
	for 1..$r-1 {
		my @val=sort($e,$_,$r-$_);
		%s{@val.join(",")}=@val if @val.sum ==12;
	}
}

for %s.keys.sort {
	put %s{$_}.join(",");
}
