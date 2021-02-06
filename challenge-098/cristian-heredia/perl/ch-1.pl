=begin

TASK #1 › Read N-characters
Submitted by: Mohammad S Anwar
You are given file $FILE.

Create subroutine readN($FILE, $number) returns the first n-characters and moves the pointer to the (n+1)th character.

Example:
    Input: Suppose the file (input.txt) contains "1234567890"
    Output:
        print readN("input.txt", 4); # returns "1234"
        print readN("input.txt", 4); # returns "5678"
        print readN("input.txt", 4); # returns "90"

=end
=cut

use strict;
use warnings;
use Data::Dumper;

#Input
my $number = 4;
my $text = '1234567890';

#Variable
my $file_name = "";

#Call function
askFileName();


#Request the name of the file to the user
sub askFileName {
    
    print "Please, introduce the name of the file\n";
    $file_name = <>;
    $file_name =~ s/\s//g;
    
    #Check that the file exists, if not, it's created
    if  ( !-f $file_name) {
        createFile();
    }
    #Call the function that returns the first n-characters and moves the pointer to the (n+1)th character
    readN($file_name, $number);
}

#Create the file with a specific text
sub createFile {
        open (F, ">>$file_name") || die "Could not open file: $!\n";
        print F "$text";
        close F;
}

#Returns the first n-characters and moves the pointer to the (n+1)th character
sub readN {
    my $file = shift;
    my $N = shift;
    
    open(FILE, $file) or die "Could not read from $file\n";
    
    #Read the file, groups the characters n by n
    while (read FILE, my $char, $N) {
        print "print readN(\"$file_name\", $number); # returns \"$char\"\n";
    }
}
