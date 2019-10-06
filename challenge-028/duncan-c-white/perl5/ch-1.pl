#!/usr/bin/perl
#
# Challenge 1: "Write a script to check the file content without explicitly
# reading the content. It should accept file name with path as command
# line argument and print 'The file content is binary.' or else 'The file
# content is ascii.' accordingly."
# 
# My notes: That's bafflingly unclear!  Without "explicitly" reading
# the content, does that imply "implicitly" reading it is ok, or that
# we're really not supposed to read the content at all.  In the former
# case, I guess we can run "file" and parse the outout.  In the latter
# case, unless there's some magic metadata somewhere else, that only
# leaves file extensions.  In that case, we just need a hash of file
# extension -> binary/ascii choices. Dull both ways. I'll do the latter."
# 
# 

use v5.10;	# to get "say"
use strict;
use warnings;
use Function::Parameters;

die "Usage: ch-1.pl FILENAME+\n" if @ARGV == 0;

foreach my $filename (@ARGV)
{
	my $binary = ClassifyBinaryOrText( $filename );
	say "file $filename is ", $binary?"binary":"text";
}

my %knownbinary = map { $_ => 1 }
qw(tar gz bz2 tbz tbz2 tgz tar.gz tar.bz2 tar.bz Z tar.Z
   zip jpg gif png cpio out a o);


#
# my $binary = ClassifyBinaryOrText( $filename );
#	Classify filename into binary or text without reading
#	the content =s (why???).  So based on the extension then.
#	Returns 1 for binary, 0 for text.
#
fun ClassifyBinaryOrText( $filename )
{
	my $ext = $filename;
	$ext =~ s|^[^.]+/\.|| or return 0;
	return 1 if $knownbinary{$ext};
	return 0;
}
