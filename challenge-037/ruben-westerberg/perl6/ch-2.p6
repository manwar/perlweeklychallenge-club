#!/usr/bin/env  perl6

use HTTP::UserAgent;

print "Downloading November Data...\n";
my $res=HTTP::UserAgent.new.get("https://www.timeanddate.com/sun/uk/london?month=11&year=2019");
my $nov=$res.content;

print "Downloading December Data...\n";
$res=HTTP::UserAgent.new.get("https://www.timeanddate.com/sun/uk/london?month=12&year=2019");
my $dec= $res.content;

my $delta=extractDaylight($dec)- extractDaylight($nov);
my $sign= $delta>=0??"+"!!"-"; $delta=abs($delta);
my $hours=($delta / 3600).Int; $delta-=$hours*3600;
my $mins=($delta/60).Int; $delta-=$mins*60;

print "December gained $sign$hours:$mins:$delta (H:M:S) compared to November\n";

sub extractDaylight($text) {
	my $total =0;
	my @matches= $text~~ m:g/\<td\sclass\=\"c\str\ssep\-l\"[.*?]\>(.*?)\<\/td\>/;
	#my @matches= $text~~ m:g/\<td\sclass\=\"c\str\ssep\-1\"[.*?]\>(.*?)\<\/td\>/;
	for @matches {
		my ($h,$m,$s)=split ":",$_[0].Str;
		$total+=$h*3600+$m*60+$s;
	}
	$total;
}
