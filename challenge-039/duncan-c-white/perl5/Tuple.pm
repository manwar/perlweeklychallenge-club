package Tuple;

# jan2017: added deepclone() method.

use strict;
use warnings;
use Data::Dumper;

#
# usage: use Tuple;                   (mainly OO)
# or:    use Tuple qw(tuple);  	      (convenience function too)

use Exporter 'import';
our @EXPORT_OK = qw(tuple);


# exported convenience functions
sub tuple (@)       { return Tuple->new(@_); }


#
# my $trip = Tuple->new( @elements ):
#	Construct a new Tuple with the given values.
#
sub new ($@)
{
	my( $class, @elements ) = @_;
	my $tuple = bless [@elements], $class;
	return $tuple;
}


#
# my @elements = $tuple->detuple:
#	Return the array of elements from the tuple.
#
sub detuple ($)
{
	my( $tuple ) = @_;
	die "Tuple->detuple: bad tuple object",Dumper($tuple),"\n"
		unless defined $tuple && ref($tuple) eq "Tuple";
	return @$tuple;
}

#
# $tuple->append( $v );
#	Append $v as an extra field in $tuple (so a 3-tuple becomes a 4-tuple)
#
sub append ($$)
{
	my( $self, $v ) = @_;
	push @$self, $v;
}



use overload '""' => \&as_string;

#
# my $str = $tuple->as_string():
#	Produce a printable string form of the given tuple.
#
sub as_string ($)
{
	my( $tuple ) = @_;
	my $str = join(',', @$tuple);
	return "($str)";
}


#
# my $newtuple = $tuple->deepclone;
#	deepclone the given tuple $tuple, calling each item's deepclone
#	method and building and returning a new identical tuple with
#	no shared items..
#	ONLY CALL THIS IF ALL ITEMS ON $tuple "can" deepclone!
#
sub deepclone ($)
{
	my( $self ) = @_;
	return Tuple->new( map { $_->deepclone } @$self );
}


1;
