#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 9801.pl
#
#        USAGE: ./9801.pl FILENAME [ ENCODING ]
#
#  DESCRIPTION: Read N chars (not bytes!) at a time by filename (not handle!)
#
#      OPTIONS: The encoding defaults to "utf-8" if unspecifiied.
# REQUIREMENTS: Perl 5.10 or later (for 'state')
#        NOTES: The script does very little - it's just a demo of readN
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 01/02/21
#===============================================================================

use strict;
use warnings;
use feature 'state';

my ($filename, $ENC) = @ARGV;
$ENC //= 'utf-8';
binmode STDOUT, ":encoding($ENC)";

my $len = 4;

# Read and print the whole file, $len characters at a time
while (my $data = readN ($filename, $len)) {
	print "$data\n";
	last if $len > length $data;
}

sub readN {
	my ($filename, $len) = @_;
	state %handles;

	unless (exists $handles{$filename}) {
		open $handles{$filename}, "<:encoding($ENC)", $filename or
			die "Cannot open $ENC-encoded file $filename for reading: $!";
	}
	my $chars = sysread $handles{$filename}, (my $text), $len;
	unless ($chars == $len) {
		# We have reached the end of the file. Close the handle and
		# remove it from the hash
		close $handles{$filename};
		delete $handles{$filename};
	}
	return $text;
}
