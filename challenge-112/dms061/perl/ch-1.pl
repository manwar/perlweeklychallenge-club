use strict;
use warnings;

# Question 1: You are given a string path, starting with a slash ‘/'.
# Write a script to convert the given absolute path to the simplified canonical path.
# In a Unix-style file system:
# - A period '.' refers to the current directory
# - A double period '..' refers to the directory up a level
# - Multiple consecutive slashes ('//') are treated as a single slash '/'
# The canonical path format:
# - The path starts with a single slash '/'.
# - Any two directories are separated by a single slash '/'.
# - The path does not end with a trailing '/'.
#- The path only contains the directories on the path from the root directory to the target file or directory

my $path = "/elephant/dog/cat/../phoenix/../mouse/"; #"/a/b//c/../..";
my @stack = ();
# Build the canonical path by extracting directory names and storing them on a stack 
# unless we encounter a .., in which case we pop an element off the stack
# NOTE: this only performs the string conversion--it does not check it the path exists
#	It probably should die if the path tries to go back to a directory we don't know
#	E.g. "/../../t/" would got back past the directory structure we know from the string
#	This loop resolves that path to "/t", which isn't necessarily correct.
# 	Nonetheless, this code works for valid path inputs.

foreach ($path =~ m{/([^/]+)}g){
	#print "pulled: $_\n";
	if ($_ eq ".."){
		pop @stack;
	}else{	
		push @stack, "$_";
	}
}
print "Path to parse: $path\n";
my $canon_path = "/".join "/", @stack;
print "Canonical path: $canon_path\n";
