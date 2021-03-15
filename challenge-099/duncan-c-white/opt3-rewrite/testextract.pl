#!/usr/bin/perl
#
# scaffolding test program: test Pattern Match's
# extractmatchedtext
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;
use Test::More;

our $debug=0;
our $test=0;

use lib qw(.);
use Tuple qw(tuple);
use PatternMatch qw(extractmatchedtext);

die "Usage: textextract [--debug]\n"
	unless GetOptions( "debug" => \$debug ) && @ARGV==0;
PatternMatch::setdebug( $debug );

if( 0 )
{
	my $word = "mississippi";
	my @is = ( tuple('ss',2), tuple('s?p',6) );
	say "is $_" for @is;
	say "$word:";
	my @matchtext = extractmatchedtext( $word, 0, 0, \@is );

	foreach my $i (0..$#matchtext)
	{
		say " match text $i: $matchtext[$i]";
	}
}

dotests();

done_testing();

exit 0;


#
# dotests();
#	Do a load of tests.
#
sub dotests
{
	# format of each match test:
	# str:pat:islands:startposes:firststar:laststar:expmts
	my @matchtests = (
		"abcde:abcde:abcde:0:f:f:",
		"abcde:*:::t:t:abcde",
		"abcde:a*e:a,e:0,4:f:f:bcd",
		"abcde:abc*de:abc,de:0,3:f:f:__empty__",
		"abcde:?b*e:?b,e:0,4:f:f:a,cd",
		"abcde:a*c?e:a,c?e:0,2:f:f:b,d",

		# and here some of my own examples..
		"hellotherehowareyou:*ll*u:ll,u:2,18:t:f:he,otherehowareyo",
		"hellu:*ll*u:ll,u:2,4:t:f:he,__empty__",
		"hellou:*ll*u:ll,u:2,5:t:f:he,o",
		"helloyu:*ll*u:ll,u:2,6:t:f:he,oy",
		"helloyou:*ll*u:ll,u:2,7:t:f:he,oyo",
		"hellohellohelloyou:*ll*u:ll,u:2,17:t:f:he,ohellohelloyo",

		"hel:h*?l*:h,?l:0,1:f:t:__empty__,e,__empty__",
		"helo:h*?l*:h,?l:0,1:f:t:__empty__,e,o",
		"hello:h*?l*:h,?l:0,1:f:t:__empty__,e,lo",
		"heello:h*?l*:h,?l:0,2:f:t:e,e,lo",
		"heauellooo:h*?l*:h,?l:0,4:f:t:eau,e,looo",

		"mississippi:*s*:s:2:t:t:mi,sissippi",
		"mississippi:*ss*:ss:2:t:t:mi,issippi",
		"mississippi:*ss*s*:ss,s:2,5:t:t:mi,i,sippi",
		"mississippi:*ss*ss*:ss,ss:2,5:t:t:mi,i,ippi",
		"mississippi:*ss*ss*p*:ss,ss,p:2,5,8:t:t:mi,i,i,pi",
		"mississippi:*ss*ss*pp*:ss,ss,pp:2,5,8:t:t:mi,i,i,i",
		"mississippi:*ss*ss*p?*:ss,ss,p?:2,5,8:t:t:mi,i,i,p,i",
		"mississippi:*ss*ss*?p?*:ss,ss,?p?:2,5,7:t:t:mi,i,,i,p,i",
		"mississippi:*is*:is:1:t:t:m,sissippi",
		"mississippi:*mis*:mis:0:t:t:,sissippi",
		"mississippi:*mi?*:mi?:0:t:t:,s,sissippi",
	);

	#say "matchtests=". Dumper(\@matchtests);
	foreach my $test (@matchtests)
	{
		#say "test $test";
		# format of each match test:
		# str:pat:islands:startposes:firststar:laststar:expmts
		my( $s, $p, $islands, $sps, $firststar, $laststar, $expmts ) =
			split( /:/, $test );
		my @islands = split(/,/,$islands);
		my @sp = split(/,/,$sps);
		my @expectedmt = map { /^__empty__$/ ? '' : $_ }
			split(/,/,$expmts);

		$firststar = ($firststar eq 't'?1:0);
		$laststar = ($laststar eq 't'?1:0);

		say "p=$p, s=$s, islands=".Dumper(\@islands)."sp=".Dumper(\@sp)."firststar=$firststar, laststar=$laststar" if $debug;

		my $nislands = @islands;
		my $nsp = @sp;
		die "input error, nislands=$nislands, nsp=$nsp\n"
			unless $nsp == $nislands;

		# build integrated @is array of (island,sp) tuples
		my @is = map { tuple($islands[$_],$sp[$_]) } 0..$nsp-1;

		say "is=".Dumper(\@is) if $debug;

		my @mt = extractmatchedtext( $s, $firststar, $laststar, @is );

		#say "p=$p, s=$s, island=$islands, sps=$sps, mt=".Dumper(\@mt);
		my $nmatch = @expectedmt;
		is( scalar(@mt), $nmatch,
			"match($s,$p,$islands,$sps).#mt==$nmatch" );
		foreach my $i (0..$#mt)
		{
			is( $mt[$i], $expectedmt[$i],
			    "match($s,$p,$islands,$sps).mt[$i]==$expectedmt[$i]" );
		}
		if(0)
		{
			done_testing();
			exit 0;
		}
	}
}


1;
