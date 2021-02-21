package API;

# automatically generated implementation of recursive data type
# API	=	A(string lit,posexpr at,string name)
#	or	M(string lit,posexpr atorafter,string name)
#	or	T(posexpr pe1,string op,posexpr pe2)
#	or	C(posexpr pe1,posexpr pe2)


use strict;
use warnings;
use feature 'say';

use overload '""' => \&as_string;
use overload 'eq' => \&streq;



# API->A: Constructor or get method, use:
#   my $obj = API->A($lit, $at, $name) OR
#   my ($lit, $at, $name) = $obj->A
sub A ($;$$$)
{
	my( $thing, $lit, $at, $name ) = @_;	
	if( @_ == 4 )		# constructor
	{
		die "API->A: classname $thing is not 'API'\n"
			unless $thing eq "API";
		return bless ["A", $lit, $at, $name], "API";
	} else			# get method
	{	
		die "API->A: $thing is not a API\n"
			unless ref($thing) eq "API";
		my @x = @$thing;
		my $t = shift @x;
		die "API->A: malformed object $thing\n"
			unless @x == 3 && $t eq "A";
		return @x;
	}
}


# API->M: Constructor or get method, use:
#   my $obj = API->M($lit, $atorafter, $name) OR
#   my ($lit, $atorafter, $name) = $obj->M
sub M ($;$$$)
{
	my( $thing, $lit, $atorafter, $name ) = @_;	
	if( @_ == 4 )		# constructor
	{
		die "API->M: classname $thing is not 'API'\n"
			unless $thing eq "API";
		return bless ["M", $lit, $atorafter, $name], "API";
	} else			# get method
	{	
		die "API->M: $thing is not a API\n"
			unless ref($thing) eq "API";
		my @x = @$thing;
		my $t = shift @x;
		die "API->M: malformed object $thing\n"
			unless @x == 3 && $t eq "M";
		return @x;
	}
}


# API->T: Constructor or get method, use:
#   my $obj = API->T($pe1, $op, $pe2) OR
#   my ($pe1, $op, $pe2) = $obj->T
sub T ($;$$$)
{
	my( $thing, $pe1, $op, $pe2 ) = @_;	
	if( @_ == 4 )		# constructor
	{
		die "API->T: classname $thing is not 'API'\n"
			unless $thing eq "API";
		return bless ["T", $pe1, $op, $pe2], "API";
	} else			# get method
	{	
		die "API->T: $thing is not a API\n"
			unless ref($thing) eq "API";
		my @x = @$thing;
		my $t = shift @x;
		die "API->T: malformed object $thing\n"
			unless @x == 3 && $t eq "T";
		return @x;
	}
}


# API->C: Constructor or get method, use:
#   my $obj = API->C($pe1, $pe2) OR
#   my ($pe1, $pe2) = $obj->C
sub C ($;$$)
{
	my( $thing, $pe1, $pe2 ) = @_;	
	if( @_ == 3 )		# constructor
	{
		die "API->C: classname $thing is not 'API'\n"
			unless $thing eq "API";
		return bless ["C", $pe1, $pe2], "API";
	} else			# get method
	{	
		die "API->C: $thing is not a API\n"
			unless ref($thing) eq "API";
		my @x = @$thing;
		my $t = shift @x;
		die "API->C: malformed object $thing\n"
			unless @x == 2 && $t eq "C";
		return @x;
	}
}


sub kind ($)
{
	my( $self ) = @_;
	die "API->kind: $self is not a API\n"
		unless ref($self) eq "API";
	return $self->[0];
}


sub as_string ($)
{
	my( $self ) = @_;
	die "API->as_string: $self is not a API\n"
		unless ref($self) eq "API";
	my @x = @$self;
	my $t  = shift @x;

	# stringify all params
	@x = map { "$_" } @x;
	
	# specific printing rules
	return "A'$x[0]' $x[1]->$x[2]" if $t eq 'A';
	return "C $x[0] $x[1]" if $t eq 'C';
	return "M'$x[0]' $x[1]->$x[2]" if $t eq 'M';
	return "T$x[0]$x[1]$x[2]" if $t eq 'T';

	# general case
	my $args = join( ',', @x );
	return $args ne "" ? "$t($args)" : "$t";
}



sub streq ($$)
{
	my( $a, $b ) = @_;
	#print "API->streq called with a=$a, b=$b\n";
	return "$a" eq "$b" ? 1 : 0;		# the sneaky way
}




my $debug = 0;
sub setdebug { my($d) = @_; $debug = $d; }

#
# my @api = parse( $input );
#	Parse $input, a string containing a comma-separated sequence
#	of Abstract Pattern Instructions, return the list of apis.
#	Die screaming if parsing fails.
#	For example, the pattern a*e is represented by the
#	following api string:
#		A'a' 0->a,A'e' slen-1->e,Te>a-1,C a+1 e-1
#	(where slen is a runtime variable representing the length of
#	the target string these APIs would eventually operate on).
#
#	The individual api forms are:
#		M'str' posexpr->name
#		A'str' posexpr->name
#		Tposexpr ('>'|'='|'>=') posexpr
#		C posexpr [posexpr]
#	where posexpr = \d+ or name or name '+'|'-' \d+ (see module PosExpr)
#
sub parse ($)
{
	my( $input ) = @_;
	my @result;
	while( $input )
	{
		# M'str' posexpr->name
		if( $input =~ s/^M\s*// )
		{
			$input =~ s/^'([^']+)'\s+// ||
				die "bad input $input in M..\n";
			my $str = $1;
			(my $pe,$input) = PosExpr::parse($input);
			die "bad input $input in M$str $pe...\n"
				unless $input =~ s/^\s*->\s*(\w+)//;
			my $pname = $1;
			my $api = API->M($str, $pe, $pname);
			say "debug: parsed api $api, rest input $input"
				if $debug;
			push @result, $api;
		}
		# A'str' posexpr->name
		elsif( $input =~ s/^A\s*// )
		{
			$input =~ s/^'([^']+)'\s+// ||
				die "bad input $input in A..\n";
			my $str = $1;
			(my $pe,$input) = PosExpr::parse($input);
			die "bad input $input in A$str $pe...\n"
				unless $input =~ s/^\s*->\s*(\w+)//;
			my $pname = $1;
			my $api = API->A($str, $pe, $pname);
			say "debug: parsed api $api, rest input $input"
				if $debug;
			push @result, $api;
		}
		# Tposexpr ('>'|'='|'>=') posexpr
		elsif( $input =~ s/^T\s*// )
		{
			(my $pe,$input) = PosExpr::parse($input);
			$input =~ s/^(>=|>|=)// ||
				die "bad input $input in T$pe, ".
				    "'>','=' or '>=' expected\n";
			my $op = $1;
			(my $pe2,$input) = PosExpr::parse($input);
			my $api = API->T($pe, $op, $pe2);
			say "debug: parsed api $api, rest input $input"
				if $debug;
			push @result, $api;
		}
		# C posexpr [posexpr]
		elsif( $input =~ s/^C\s*// )
		{
			(my $pe,$input) = PosExpr::parse($input);
			$input =~ s/^\s*//;

			# second posexpr is optional:
			# present if next ch is not ','
			my $pe2 = $pe;
			if( $input ne '' && $input !~ /^,/ )
			{
				($pe2,$input) = PosExpr::parse($input);
			}
			my $api = API->C($pe, $pe2);
			say "debug: parsed api $api, rest input $input"
				if $debug;
			push @result, $api;
		}
		$input =~ s/^\s*,\s*//;
	}
	die "bad input $input, non empty but not M|T|C..\n" if $input;
	return @result;
}


1;

