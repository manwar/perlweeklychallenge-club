#!/usr/bin/perl

# This function "composes" subroutines using old features from perl 4:
# package vars, typeglobs, and the symbol table.

#-- The subroutine call &compose(*g,*f) returns sub { &g(@g) }
#-- where &f(@f) is one of the arguments in @g
#-- and $g (int) indicates the position in which &f is spliced into
#-- @g


#-- approach using typeglobs (perl 4 style)
#-- does not return a subroutine, evaluates g(f()) and returns the result
sub compose {
	local (*g, *f)=@_;
	splice(@g,$g,0,&f(@f));
	return &g(@g); #-- not a subroutine ref
}

#-- alt (same as compose but returning a string to be eval'ed)
sub alt_compose {
	local (*g, *f)=@_;
	splice(@g,$g,0,&f(@f));
	return '&'.substr(*g,1).'('.join(',',@g).')'; 
}


#-- this is the direct solution to the challenge: modern Perl
sub alt_2_compose { #-- for the simple case g(f(x)) [no other g params]
	my ($rg, $rf, @x)=@_;
	return sub { &$rg(&$rf(@x))  };
}


#-- example find sum ( factors (30) ) using compose,etc.

use Math::Factor::XS qw(factors); 

{#-- example: print sum (factors (30)) using compose
local @factors=(30); #-- @_ for factors
local $sum=0; #-- location to insert &factors in sum @_
local @sum=(); #-- sum @_ excluding &myfactors(..)
print "compose: ",&compose(*sum, *factors),"\n"; #-- 41
@sum=(); #-- reset before alternative compose 
print "alt_compose: ",eval(&alt_compose(*sum,*factors)),"\n"; #--41
}

print &{"alt_2_compose: ",&alt_2_compose('sum','factors',30)},"\n"; #-- 41

sub sum {
#-- sum over an array
	my $sum=0;
	return ( (map {$sum += $_} @_ ) [-1] );
}

