#!/usr/bin/perl

package Div;

use strict;
use warnings;
use Data::Dumper qw(Dumper);
require Exporter;

=head1 NAME

Div - Division by Zero Test

=head1 SYNOPSIS

 use Div qw(debug);
 my $DEBUG=0;

 my $a = Div->new(4);
 my $b = 2; 
  or 
 my $b = 0;
 my $r = $a/$b;
 print "Division $a/$b = $r\n";
 debug($a,$b,$r) if $DEBUG;

=head1 DESCRIPTION

This is Task#01 of Perl Weekly Challenge #31 / 2019. A division by Zero shall
be recognized without evaluating the divisor for zero value. Here it is done
with traping the exception in an C<eval> block. The result (scalar ref) is
blessed.

	eval { $res = $$self / $divisor };
	if($@ =~ /division by zero/) { $ret = "Division by zero is not allowed!"; }
	else { $ret = ref $res ? $res : bless \$res; }

Additionally a class for the division C<Div> is defined and the "/" operator 
is overloaded. A static debug function can be imported, that shows  the
blessing of a scalar ref. 

 use overload 
	'/' => \&divide,
	'""' => \&out,
	'fallback' => 1;

=cut

use overload 
	'/' => \&divide,
	'""' => \&out,
	'fallback' => 1;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(debug);
$Data::Dumper::Indent=0;

=head2 new() - Constructor

Creates a number as Dividend.

 my $a = Div->new(4);

=cut

sub new {
	my ($class,$n) = @_;
	my $self = \$n;
	bless $self, $class;
}

=head2 divide() - division

Divides the object with a number.

 my $result = $a->divide(2);
  or
 my $result = $a / 2;

=cut

sub divide {
	my ($self,$divisor) = @_;
	my ($ret,$res);
	eval { $res = $$self / $divisor };
	if($@ =~ /division by zero/) { $ret = "Division by zero is not allowed!"; }
	else { $ret = ref $res ? $res : bless \$res; }
	return $ret;
}

=head2 out() - output

Output of the object. This methode needs to be defined and the '""' needs to
be overloaded with this function.

Otherwise the output of the number in a print function would not work.

 print "Dividend: $a"

=cut

sub out { my $self = shift; return $$self; }

=head2 debug() - debugging of blessed scalar ref

This is a static function to show the blessing of a scalar reference.
Because it is outside the object I did an Export on it, that it can be
used without Class name.

=cut

sub debug {
	my (@v) = @_;
	for(my $i=0; $i<=$#v; $i++) { 
		my $w = $v[$i];
		printf("Value %02d: %-10s (%2s) %s\n",$i,ref($w),$w,Dumper($w));
	}
}

=head1 AUTHOR

Chuck

=cut

1;
