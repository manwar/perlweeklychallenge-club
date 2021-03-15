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
		"abcde:abcde:Tslen=5,A'abcde' 0->a:1:",
		"abcdef:abcde:Tslen=5,A'abcde' 0->a:0:",
		"abcde:abcdef:Tslen=6,A'abcdef' 0->a:0:",
		"abcde:*:C 0 slen-1:1:abcde",
		"abcde:a*e:A'a' 0->a,A'e' slen-1->e,Te>a,C a+1 e-1:1:bcd",
		"abcde:abc*de:A'abc' 0->a,A'de' slen-2->d,Td>a+2,C a+3 d-1:1:__empty__",
		"abcde:a*d:A'a' 0->a,A'd' slen-1->d,Td>a-1,C a+1 d-1:0:",
		"abcde:?b*d:A'd' slen-1->d,A'b' 1->b,C 0,C b+1 d-1:0:",
		"abcde:?b*e:A'e' slen-1->e,A'b' 1->b,C 0,C b+1 e-1:1:a,cd",
		"abcde:a*c?e:A'a' 0->a,A'e' slen-1->e,A'c' e-2->c,".
			"C a+1 c-1,C c+1:1:b,d",
		"hellotherehowareyou:*ll*u:A'u' slen-1->u,M'll' 0->l,Tu>=l,".
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
