package TestMatch2;

use strict;
use warnings;
use feature 'say';
use Data::Dumper;
use Function::Parameters;
use Test::More;

use Exporter;
our @ISA = qw(Exporter);

our @EXPORT_OK = qw(match_tests); # Export on demand

use lib qw(.);
use Translate qw(pat2apis);

my $debug = 0;

sub setdebug { my($d) = @_; $debug = $d; Translate::setdebug($d); }


#
# match_tests( $patmatch );
#	Do a load of match tests, using the $patmatch->() function,
#	really using the pattern this time.  we compile each pattern into
#	a api list, then string match the string against the api list.
#
fun match_tests( $patmatch )
{
	# format of each match test: S:P:expmatch:expmt
	my @matchtests = (
		"abcde:abcde:1:",
		"abcdef:abcde:0:",
		"abcde:abcdef:0:",
		"abcde:*:1:abcde",
		"abcde:a*e:1:bcd",
		"abcde:abc*de:1:__empty__",
		"abcde:a*d:0:",
		"abcde:?b*d:0:",
		"abcde:?b*e:1:a,cd",
		"abcde:a*c?e:1:b,d",

		# and here some of my own examples..
		"hellotherehowareyou:*ll*u:1:he,otherehowareyo",
		"hellu:*ll*u:1:he,__empty__",
		"hellou:*ll*u:1:he,o",
		"helloyu:*ll*u:1:he,oy",
		"helloyou:*ll*u:1:he,oyo",
		"hellohellohelloyou:*ll*u:1:he,ohellohelloyo",

		"hlo:h*?l*:0:",
		"hel:h*?l*:1:__empty__,e,__empty__",
		"helo:h*?l*:1:__empty__,e,o",
		"hello:h*?l*:1:__empty__,e,lo",
		"heello:h*?l*:1:e,e,lo",
		"heauellooo:h*?l*:1:eau,e,looo",

		"mississippi:*s*:1:mi,sissippi",
		"mississippi:*ss*:1:mi,issippi",
		"mississippi:*ss*s*:1:mi,i,sippi",
		"mississippi:*ss*ss*:1:mi,i,ippi",
		"mississippi:*ss*ss*p*:1:mi,i,i,pi",
		"mississippi:*ss*ss*pp*:1:mi,i,i,i",
		"mississippi:*ss*ss*p?*:1:mi,i,i,p,i",
		"mississippi:*ss*ss*?p?*:1:mi,i,,i,p,i",
		"mississippi:*is*:1:m,sissippi",
		"mississippi:*mis*:1:,sissippi",
		"mississippi:*mi?*:1:,s,sissippi",
	);

	#say "matchtests=". Dumper(\@matchtests);
	foreach my $test (@matchtests)
	{
		#say "test $test";
		my( $s, $p, $expmatch, $expmts ) = split( /:/, $test );
		$expmatch //= '0';
		my @expectedmt = map { /^__empty__$/ ? '' : $_ }
			split(/,/,$expmts);
		my @api = pat2apis( $p );
		say "apis:" if $debug;
		say join("\n", map { "  $_" } @api ) if $debug;

		my( $match, @mt ) = $patmatch->( $s, @api );
		#say "p=$p, s=$s, match=$match, mt=".Dumper(\@mt);
		is( $match, $expmatch, "match($s,$p)=$expmatch" );
		if( $match )
		{
			my $nmatch = @expectedmt;
			is( scalar(@mt), $nmatch,
				"match($s,$p).#mt==$nmatch" );
			foreach my $i (0..$#mt)
			{
				is( $mt[$i], $expectedmt[$i],
				    "match($s,$p).mt[$i]==$expectedmt[$i]" );
			}
		}
	}
}


1;
