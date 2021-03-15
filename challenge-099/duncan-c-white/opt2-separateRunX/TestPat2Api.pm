package TestPat2Api;

#
# Tests 
#

use strict;
use warnings;
use feature 'say';
use Data::Dumper;
use Function::Parameters;
use Test::More;

use Exporter;
our @ISA = qw(Exporter);

our @EXPORT_OK = qw(pat2api_tests); # Export on demand

use lib qw(.);
use PosExpr;
use API;
use Translate qw(pat2apis);


my $debug = 0;

sub setdebug { my($d) = @_; $debug = $d; }


#
# pat2api_tests();
#	Do a load of pat2api tests.
#
sub pat2api_tests
{
	# format of each pat2api test: P:API(p)
	our @pat2apitests = (
		"*:C 0 slen-1",
		"abcde:Tslen=5,A'abcde' 0->a",
		"abcdef:Tslen=6,A'abcdef' 0->a",
		"abc?e?:Tslen=6,A'abc' 0->a,A'e' a+4->e,C a+3 a+3,C e+1 e+1",
		"a*e:Tslen>=2,A'a' 0->a,A'e' slen-1->e,Te>=a+1,C a+1 e-1",
		"ab*e:Tslen>=3,A'ab' 0->a,A'e' slen-1->e,Te>=a+2,C a+2 e-1",
		"ab*de:Tslen>=4,A'ab' 0->a,A'de' slen-2->d,Td>=a+2,C a+2 d-1",
		"abc*de:Tslen>=5,A'abc' 0->a,A'de' slen-2->d,Td>=a+3,C a+3 d-1",
		"?b*d:Tslen>=3,A'b' 1->b,A'd' slen-1->d,Td>=b+1,C 0 0,C b+1 d-1",
		"?bc*e:Tslen>=4,A'bc' 1->b,A'e' slen-1->e,Te>=b+2,C 0 0,C b+2 e-1",
		# optimal for "a*c?e is Tslen>=4,A'a' 0->a,A'e' slen-1->e,A'c' e-2->c,C a+1 c-1,C c+1",
		"a*c?e:Tslen>=4,A'a' 0->a,A'c' slen-3->c,A'e' c+2->e,Te-2>=a+1,C a+1 e-3,C c+1 c+1",
		"*ll*u:Tslen>=3,A'u' slen-1->u,M'll' 0->l,Tu>=l+2,C 0 l-1,C l+2 u-1",	# my example..
	);

	say "pat2apitests=". Dumper(\@pat2apitests) if $debug;
	foreach my $test (@pat2apitests)
	{
		say "test $test" if $debug;
		my( $pat, $expectedapi ) = split( /:/, $test );
		my @api = pat2apis( $pat );
		my $apistr = join( ',', map { "$_" } @api );
		is( $apistr, $expectedapi, "pat2apis($pat)=$expectedapi" );
	}
}

1;
