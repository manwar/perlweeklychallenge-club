use strict;
use warnings;
##
# Write a script to display all valid phone numbers in a given text file.     
##
use Capture::Tiny q/capture_stdout/;
use PhoneNumberParser;

MAIN:{
    my $parser = new PhoneNumberParser();
    while(my $line = <DATA>){
        $line =~ s/^\s+|\s+$//g;
        my $syntax_error = capture_stdout {
            $parser->parse($line); 
        };
        print("$line\n") if !$syntax_error;
    }
}   

__DATA__
0044 1148820341
 +44 1148820341
  44-11-4882-0341
(44) 1148820341
 00 1148820341