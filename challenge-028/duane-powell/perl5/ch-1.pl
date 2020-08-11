#!/usr/bin/perl
use Modern::Perl;

# Write a script to check the file content without explicitly reading the content. 
# It should accept file name with path as command line argument and print 
# "The file content is binary." or else "The file content is ascii." accordingly.

my $file = shift;
if ($file) {
	if (-e $file) {
		say "The file $file content is binary" if (-B $file);
		say "The file $file content is ascii"  if (-T $file);
	} else {
		say "The file $file does not exist";
	}
} else {
	say "Usage: $0 filename";
}

__END__

./ch-1.pl
Usage: ./ch-1.pl filename

./ch-1.pl filename
The file filename does not exist

./ch-1.pl ch-2.pl
The file ch-2.pl content is ascii

./ch-1.pl /tmp/data.tgz
The file /tmp/data.tgz content is binary

