use strict;
use warnings;
##
# Write a script to check the file content without explicitly reading the content. 
# It should accept file name with path as command line argument and 
# print "The file content is binary." or else “The file content is ascii.” accordingly.
##  
use File::MMagic;
use constant TEXT_TYPE => "The file content is ascii.";
use constant BINARY_TYPE => "The file content is binary.";
 
my $fm = new File::MMagic();
my $type = $fm->checktype_filename($ARGV[0]);
if($type=~m/text\//){ 
    print TEXT_TYPE . "\n";
}   
else{ 
    print BINARY_TYPE . "\n";
}   
