package PosExpr;

# automatically generated implementation of recursive data type
# PosExpr	=	I(int n)
#	or	N(string name)
#	or	NO(string name,char op,int n)


use strict;
use warnings;
use feature 'say';

use overload '""' => \&as_string;
use overload 'eq' => \&streq;



# PosExpr->I: Constructor or get method, use:
#   my $obj = PosExpr->I($n) OR
#   my $n = $obj->I
sub I ($;$)
{
	my( $thing, $n ) = @_;	
	if( @_ == 2 )		# constructor
	{
		die "PosExpr->I: classname $thing is not 'PosExpr'\n"
			unless $thing eq "PosExpr";
		return bless ["I", $n], "PosExpr";
	} else			# get method
	{	
		die "PosExpr->I: $thing is not a PosExpr\n"
			unless ref($thing) eq "PosExpr";
		my @x = @$thing;
		my $t = shift @x;
		die "PosExpr->I: malformed object $thing\n"
			unless @x == 1 && $t eq "I";
		return $x[0];
	}
}


# PosExpr->N: Constructor or get method, use:
#   my $obj = PosExpr->N($name) OR
#   my $name = $obj->N
sub N ($;$)
{
	my( $thing, $name ) = @_;	
	if( @_ == 2 )		# constructor
	{
		die "PosExpr->N: classname $thing is not 'PosExpr'\n"
			unless $thing eq "PosExpr";
		return bless ["N", $name], "PosExpr";
	} else			# get method
	{	
		die "PosExpr->N: $thing is not a PosExpr\n"
			unless ref($thing) eq "PosExpr";
		my @x = @$thing;
		my $t = shift @x;
		die "PosExpr->N: malformed object $thing\n"
			unless @x == 1 && $t eq "N";
		return $x[0];
	}
}


# PosExpr->NO: Constructor or get method, use:
#   my $obj = PosExpr->NO($name, $op, $n) OR
#   my ($name, $op, $n) = $obj->NO
sub NO ($;$$$)
{
	my( $thing, $name, $op, $n ) = @_;	
	if( @_ == 4 )		# constructor
	{
		die "PosExpr->NO: classname $thing is not 'PosExpr'\n"
			unless $thing eq "PosExpr";
		return bless ["NO", $name, $op, $n], "PosExpr";
	} else			# get method
	{	
		die "PosExpr->NO: $thing is not a PosExpr\n"
			unless ref($thing) eq "PosExpr";
		my @x = @$thing;
		my $t = shift @x;
		die "PosExpr->NO: malformed object $thing\n"
			unless @x == 3 && $t eq "NO";
		return @x;
	}
}


sub kind ($)
{
	my( $self ) = @_;
	die "PosExpr->kind: $self is not a PosExpr\n"
		unless ref($self) eq "PosExpr";
	return $self->[0];
}


sub as_string ($)
{
	my( $self ) = @_;
	die "PosExpr->as_string: $self is not a PosExpr\n"
		unless ref($self) eq "PosExpr";
	my @x = @$self;
	my $t  = shift @x;

	# stringify all params
	@x = map { "$_" } @x;
	
	# specific printing rules
	return "$x[0]" if $t eq 'I';
	return "$x[0]" if $t eq 'N';
	return "$x[0]$x[1]$x[2]" if $t eq 'NO';

	# general case
	my $args = join( ',', @x );
	return $args ne "" ? "$t($args)" : "$t";
}



sub streq ($$)
{
	my( $a, $b ) = @_;
	#print "PosExpr->streq called with a=$a, b=$b\n";
	return "$a" eq "$b" ? 1 : 0;		# the sneaky way
}



use Data::Dumper;

my $debug = 0;
sub setdebug { my($d) = @_; $debug = $d; }

#
# my($pe,$leftover) = parse($input);
#	Parse $input, a string starting with a position expression,
#	delivering the position expression in $pe and the leftover
#	input in $leftover.  Die screaming if no well formed pos expr
#	can be found at the start of $input.
#	A position expression is either \d+ or name or name '+'|'-' \d+
#	The internal form of a posexpr is ['I', int const] or ['N', name]
#	or ['NO', name, +-, offset]
#
sub parse ($)
{
	my( $input ) = @_;
	if( $input =~ s/^(\d+)\s*// )
	{
		return ( PosExpr->I($1), $input );
	}
	$input =~ s/^(\w+)\s*// ||
		die "bad input in pos expr $input, name expected\n";
	my $name = $1;
	if( $input =~ s/^([\+-])\s*(\d+)\s*// )
	{
		if( $2 == 0 )
		{
			return ( PosExpr->N($name), $input );
		} else
		{
			return ( PosExpr->NO($name,$1,$2), $input );
		}
	}
	return ( PosExpr->N($name), $input );
}

#
# my $pe = simpleparse($str);
#	Parse a position expression out of $str.  Fail if there's
#	anything left over.
#
sub simpleparse ($)
{
	my( $str ) = @_;
	my($pe,$leftover) = parse($str);
	die "PosExpr->simpleparse($str): left over $leftover after pe $pe\n"
		if $leftover;
	return $pe;
}


#
# my $newpe = $pe->add($n);
#	Arithmetic on PosExprs: add $n (an integer)
#	to $pe, giving $newpe.
#
sub add
{
	my( $self, $n ) = @_;
	return $self if $n==0;
	if( $self->kind eq 'I' )
	{
		my $x = $self->I;
		return PosExpr->I( $x+$n );
	} elsif( $self->kind eq "N" )
	{
		my $name = $self->N;
		my $op = $n>0?'+':'-';
		$n = abs($n);
		return PosExpr->NO( $name, $op, $n );
	} else
	{
		# .. NO( string name, char op, int n )
		my( $name, $op, $x ) = $self->NO;
		$x = -$x if $op eq '-';
		$op = '+';
		$x += $n;
		return PosExpr->N( $name ) if $x==0;
		$op = '-' if $x<0;
		$x = abs($x);
		return PosExpr->NO( $name, $op, $x );
	}
}


#
# my $pos = $pe->eval($poshash);
#	Evaluate the given PosExpr $pe, using %$poshash
#	for name lookup.  Returns the actual position (a number).
#
sub eval ($$)
{
	my( $self, $poshash ) = @_;
	if( $self->kind eq 'I' )
	{
		return $self->I;
	} elsif( $self->kind eq 'N' )
	{
		my $name = $self->N;
		die "error in PosExpr::eval($self): ".
		    "no such name $name in poshash ". Dumper($poshash)
			unless exists $poshash->{$name};
		return $poshash->{$name};
	} else    # if( $self->kind eq 'NO' )
	{
		my ($name, $op, $n) = $self->NO;
		die "error in PosExpr::eval($self): ".
		    "no such name $name in poshash ". Dumper($poshash)
			unless exists $poshash->{$name};
		die "error in PosExpr::eval($self): bad op $op\n" unless
			$op eq '+' || $op eq '-';
		$n = - $n if $op eq '-';
		return $poshash->{$name} + $n;
	}
}





1;

