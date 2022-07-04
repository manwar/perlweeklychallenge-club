### https://theweeklychallenge.org/blog/perl-weekly-challenge-171/
#
### Task 2: First-class Function
### Submitted by: Mohammad S Anwar
### Create sub compose($f, $g) which takes in two parameters $f and $g as subroutine refs and returns subroutine ref i.e. compose($f, $g)->($x) = $f->($g->($x))
### 
### 
### e.g.
### 
### $f = (one or more parameters function)
### $g = (one or more parameters function)
### 
### $h = compose($f, $g)
### $f->($g->($x,$y, ..)) == $h->($x, $y, ..) for any $x, $y, ...
#
use strict;
use warnings;

sub Sumdigit{
	return map{ eval( join " + ", split // ) } @_;
}

sub Square{
	return map{ $_**2 } @_;
}

sub compose{
	my @f = @_;
	my $f = shift @f;
	return @f ? sub{ $f->(compose(@f)->(@_)) } : $f;
}

my $SquareAfterSumdigit = compose(\&Square,\&Sumdigit);
my $SumdigitAfterSquare = compose(\&Sumdigit,\&Square);

my @a = (19,29,39);

printf 'Sumdigit(%s) = (%s) => Square(%2$s) = (%s)', map{join ", ", @$_} \@a, [&Sumdigit(@a)], [&Square(&Sumdigit(@a))];
printf "\n=> SqaureAfterSumdigit(%s) = (%s)\n\n", map{join ", ", @$_} \@a, [&$SquareAfterSumdigit(@a)];

printf 'Square(%s) = (%s) => Sumdigit(%2$s) = (%s)', map{join ", ", @$_} \@a, [&Square(@a)], [&Sumdigit(&Square(@a))];
printf "\n=> SumdigitAfterSquare(%s) = (%s)\n", map{join ", ", @$_} \@a, [&$SumdigitAfterSquare(@a)];
