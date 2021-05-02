=begin
    Task #1 › Valid Phone Numbers
    Submitted by: Mohammad S Anwar
    You are given a text file.
    
    Write a script to display all valid phone numbers in the given text file.
    
    Acceptable Phone Number Formats
        +nn  nnnnnnnnnn
        (nn) nnnnnnnnnn
        nnnn nnnnnnnnnn
    
    Input File
        0044 1148820341
        +44 1148820341
        44-11-4882-0341
        (44) 1148820341
        00 1148820341
    Output
        0044 1148820341
        +44 1148820341
        (44) 1148820341
=end
=cut

use strict;
use warnings;

#Variables
my $file_name = "";
my $text = <<'END_MESSAGE';
0044 1148820341
+44 1148820341
44-11-4882-0341
(44) 1148820341
00 1148820341
END_MESSAGE

#regex
    #+nn  nnnnnnnnnn
        #\+\d{2}\s\d{10}
    #(nn) nnnnnnnnnn
        #\(\d{2}\)\s\d{10}
    #nnnn nnnnnnnnnn
        #\d{4}\s\d{10}

#Call function
askFileName();
print "Output\n";
readTelf($file_name);

#Check the valid phone numbers
sub askFileName {
    
    print "Please, introduce the name of the file\n";
    $file_name = <>;
    $file_name =~ s/\s//g;
    
    #Check that the file exists, if not, it's created
    if  ( !-f $file_name) {
        createFile();
    }
}

#Create the file with a specific text
sub createFile {
    
    open (F, ">>$file_name") || die "Could not open file: $!\n";
    print F "$text";
    close F;
}

sub readTelf {
    
    my $file = shift;
    open(FILE, $file) or die "Could not read from $file\n";
    
    #Read the file, line by line and find the valid phone numbers
    while( my $line = <FILE>)  {   
        if ($line =~ /\+\d{2}\s\d{10}/ or $line =~ /\(\d{2}\)\s\d{10}/ or $line =~ /\d{4}\s\d{10}/) {
            print "$line";    
        }
    }
}





