package TestMatch;

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
use API;

my $debug = 0;

sub setdebug { my($d) = @_; $debug = $d; }


#
# match_tests( $patmatch );
#	Do a load of match tests using the $patmatch->() function, using the
#	pattern only for info: we are really matching the string against
#	the api list.
#
fun match_tests( $patmatch )
{
	# format of each match test: S:P:API(p):expmatch:expmt
	my @matchtests = (
		"abcde:abcde:Tslen=5,F'abcde'->a:1:",
		"abcdef:abcde:Tslen=5,F'abcde'->a:0:",
		"abcde:abcdef:Tslen=6,F'abcdef'->a:0:",
		"abcde:*:C 0 slen-1:1:abcde",
		"abcde:a*e:F'a'->a,L'e'->e,Te>a,C a+1 e-1:1:bcd",
		"abcde:abc*de:F'abc'->a,L'de'->d,Td>a+2,C a+3 d-1:1:__empty__",
		"abcde:a*d:F'a'->a,L'd'->d,Td>a-1,C a+1 d-1:0:",
		"abcde:?b*d:L'd'->d,A'b' 1->b,C 0,C b+1 d-1:0:",
		"abcde:?b*e:L'e'->e,A'b' 1->b,C 0,C b+1 e-1:1:a,cd",
		"abcde:a*c?e:F'a'->a,L'e'->e,A'c' e-2->c,".
			"C a+1 c-1,C c+1:1:b,d",
		"hellotherehowareyou:*ll*u:L'u'->u,M'll' 0->l,Tu>=l,".
		"C 0 l-1,C l+2 u-1:1:he,otherehowareyo",	# my example..
	);

	#say "matchtests=". Dumper(\@matchtests);
	foreach my $test (@matchtests)
	{
		#say "test $test";
		my( $s, $p, $api, $expmatch, $expmts ) = split( /:/, $test );
		$expmatch //= '0';
		my @expectedmt = map { /^__empty__$/ ? '' : $_ }
			split(/,/,$expmts);
		my @api = API::parse( $api );
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
