package TestPE;

use strict;
use warnings;
use feature 'say';
use Data::Dumper;
use Function::Parameters;
use Test::More;

use Exporter;
our @ISA = qw(Exporter);

our @EXPORT_OK = qw(pe_tests); # Export on demand

use lib qw(.);
use PosExpr;

my $debug = 0;

sub setdebug { my($d) = @_; $debug = $d; }


#
# pe_tests();
#	Do a load of PosExpr tests.
#
sub pe_tests
{
	# format of each PosExpr test: pe:op:arg:result
	my @petests = (
		"10:parse::10",
		"x:parse::x",
		"x,y:parse:,y:x",
		"x,y+7:parse:,y+7:x",
		"x+1,z:parse:,z:x+1",
		"x+17:parse::x+17",
		"x-17:parse::x-17",
		"10:add:10:20",
		"10:add:-10:0",
		"x:add:10:x+10",
		"x+10:add:10:x+20",
		"x+10:add:-10:x",
		"x-1:add:1:x",
		"x-1:add:2:x+1",
		"x-1:add:-1:x-2",
		"1:eval:3:1",
		"x:eval:3:3",
		"x-1:eval:3:2",
		"x+7:eval:3:10",
	);

	#say "petests=". Dumper(\@petests);
	foreach my $test (@petests)
	{
		#say "test $test";
		my( $pstr, $op, $arg, $expresult ) = split( /:/, $test );
		my($pe,$leftover) = PosExpr::parse($pstr);
		if( $op eq "parse" )
		{
			is( "$pe", $expresult, "parse($pstr)==$expresult" );
			is( $leftover, $arg, "parse($pstr).leftover==$arg" );
		} elsif( $op eq "add" )
		{
			$pe = $pe->add( $arg );
			is( "$pe", $expresult, "add($pstr,$arg)==$expresult" );
		} elsif( $op eq "eval" )
		{
			my $result = $pe->eval( { 'x' => $arg } );
			is( $result, $expresult,
				"eval($pstr w x=$arg)==$expresult" );
		} else
		{
			die "bad test $test\n";
		}
	}
}


1;
