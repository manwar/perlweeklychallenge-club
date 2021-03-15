#!/usr/bin/perl
#
# Task 1: "Read N-characters
# 
# You are given file $FILE.
# 
# Create subroutine readN($FILE, $number) returns the first n-characters
# and moves the pointer to the (n+1)th character.
# 
# Example:
# 
# Input: Suppose the file (input.txt) contains "1234567890"
# Output:
#     print readN("input.txt", 4); # returns "1234"
#     print readN("input.txt", 4); # returns "5678"
#     print readN("input.txt", 4); # returns "90"
# "
# 
# My notes: weird question, hiding IO handles, so presumably a hash of filenames
# to IO handles is needed?
# 

use strict;
use warnings;
use feature 'say';
use Data::Dumper;

die "Usage: readN filename1:N1 [filename2:N2...]\n" unless @ARGV>=1;
foreach my $fn (@ARGV)
{
	die "readN: argument should be of the form filename:N\n"
		unless $fn =~ /^([^:]+):(\d+)$/;
	my( $f, $n ) = ( $1, $2 );
	say "readN($f,$n) = ".readN( $f, $n );
}


#
# my $str = readN( $filename, $nchars );
#	Read the next $nchars from $filename.
#
my %filename2fh;
sub readN
{
	my( $filename, $nchars ) = @_;
	my $fh = $filename2fh{$filename};
	unless( defined $fh )
	{
		open( $fh, '<', $filename ) ||
			die "readN: can't open $filename\n";
		$filename2fh{$filename} = $fh;
	}
	my $s = "";
	my $nread = sysread( $fh, $s, $nchars );

	# if hit eof, close filehandle for neatness
	# (this would case future calls to readN from this
	# same filename will simply reread the file from the
	# beginning.  But if we don't do this, we never
	# close any filehandles.
	if( $nchars > 0 && $nread == 0 )
	{
		close $fh;
		delete $filename2fh{$filename};
	}
	return $s;
}
