#Square Secret Code
#The squate secret code mechanism first removes any space from the original message. 
#Then it lays down the message in a row of 8 columns. 
#The coded message is then obtained by reading down the columns going left to right.
#
#For example, the message is “The quick brown fox jumps over the lazy dog”.
#
#Then the message would be laid out as below:
#
#thequick
#brownfox
#jumpsove
#rthelazy
#dog
#The code message would be as below:
#
#tbjrd hruto eomhg qwpe unsl ifoa covz kxey
#Write a script that accepts a message from command line and prints the equivalent coded message.


use strict;
use warnings;
use Data::Dumper;


my $askForInput = 1;
my $errorMessage = '';
my $columnLength = 8;

while ($askForInput){

    if ($errorMessage ){
        print "ERROR: $errorMessage\n";
    }
    my $input = getInput();
    print "Input: '$input'\n";
    if ($input =~ /^q|quit$/i){
        print "Bye bye\n";
        $askForInput = 0;
    } elsif ($input =~ /\S+/){
        $errorMessage = '';
        my $messageEncoded = encodeMessage($input);
        print "\n>>>>>>>>>>>>>>>>Encoded message: $messageEncoded\n";
    } else {
       $errorMessage =  "ERROR, no valid message was entered\n";		
    }	
	
}

sub getInput {   
    print "------------------------------\n";
    print "Enter your message to be coded\nEnter quit(q) to exit\n";
    print "------------------------------\n";	
    my $input = <STDIN>;
    chomp($input);	
    return $input;
}

sub encodeMessage {
    my $message = shift;
    my @aSubMessages = ();
    my $messageEncoded = '';
    $message =~ s%\s+%%g;	
    my @aEncodedGroups = ();
    my @aMessage = split ('', $message);
    foreach my $indexMessage  (0..$#aMessage){
        my $indexSubgroup = $indexMessage % $columnLength ;
        unless  (defined $aEncodedGroups[$indexSubgroup]){
            $aEncodedGroups[$indexSubgroup] = '';
        }
        $aEncodedGroups[$indexSubgroup] .= $aMessage[$indexMessage]; #t
    }  
    $messageEncoded = join(' ', @aEncodedGroups);    
    return $messageEncoded ;
}
