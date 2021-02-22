package API;

# automatically generated implementation of recursive data type
# API	=	F(string lit,string name)
#	or	L(string lit,string name)
#	or	M(string lit,posexpr atorafter,string name)
#	or	A(string lit,posexpr at,string name)
#	or	T(posexpr pe1,string op,posexpr pe2)
#	or	C(posexpr pe1,posexpr pe2)


use strict;
use warnings;
use feature 'say';

use overload '""' => \&as_string;
use overload 'eq' => \&streq;



# API->F: Constructor or get method, use:
#   my $obj = API->F($lit, $name) OR
#   my ($lit, $name) = $obj->F
sub F ($;$$)
{
	my( $thing, $lit, $name ) = @_;	
	if( @_ == 3 )		# constructor
	{
		die "API->F: classname $thing is not 'API'\n"
			unless $thing eq "API";
		return bless ["F", $lit, $name], "API";
	} else			# get method
	{	
		die "API->F: $thing is not a API\n"
			unless ref($thing) eq "API";
		my @x = @$thing;
		my $t = shift @x;
		die "API->F: malformed object $thing\n"
			unless @x == 2 && $t eq "F";
		return @x;
	}
}


# API->L: Constructor or get method, use:
#   my $obj = API->L($lit, $name) OR
#   my ($lit, $name) = $obj->L
sub L ($;$$)
{
	my( $thing, $lit, $name ) = @_;	
	if( @_ == 3 )		# constructor
	{
		die "API->L: classname $thing is not 'API'\n"
			unless $thing eq "API";
		return bless ["L", $lit, $name], "API";
	} else			# get method
	{	
		die "API->L: $thing is not a API\n"
			unless ref($thing) eq "API";
		my @x = @$thing;
		my $t = shift @x;
		die "API->L: malformed object $thing\n"
			unless @x == 2 && $t eq "L";
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
	return "F'$x[0]'->$x[1]" if $t eq 'F';
	return "L'$x[0]'->$x[1]" if $t eq 'L';
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
#		F'a'->a,L'e'->e,Te>a-1,C a+1 e-1
#	The individual api forms are:
#		F'str'->name
#		L'str'->name
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
		# F'str'->name
		if( $input =~ s/^F\s*// )
		{
			$input =~ s/^'([^']+)'\s*->\s*(\w+)// ||
				die "bad input $input in F..\n";
			my $api = API->F($1, $2);
			say "debug: parsed api $api, rest input $input"
				if $debug;
			push @result, $api;
		}
		# L'str'->name
		elsif( $input =~ s/^L\s*// )
		{
			$input =~ s/^'([^']+)'\s*->\s*(\w+)// ||
				die "bad input $input in L..\n";
			my $api = API->L($1, $2);
			say "debug: parsed api $api, rest input $input"
				if $debug;
			push @result, $api;
		}
		# M'str' posexpr->name
		elsif( $input =~ s/^M\s*// )
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
	die "bad input $input, non empty but not F|L|M|T|C..\n" if $input;
	return @result;
}


1;

