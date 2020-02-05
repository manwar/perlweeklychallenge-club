#!/usr/env/perl

#  TASK #1 Cryptic Message
# The communication system of an office is broken and message received
# are not completely reliable. Write a script to decrypt the provided
# repeated message (one message repeated 6 times).
# HINT: Look for characters repeated in a particular position
# in all six messages received.

# The broken messager replaces some characters of the message
# with other characters.  By repeatedly using the messager, we can
# collect the most frequent characters at a given position and thereby
# deal with the broken-ness.  Multiple sampling reduces errors.
# We can simulate such a messenger and test it

use strict;use warnings;
use Time::HiRes qw{sleep};

my $messages1=[  'H x l 4 !',
                 'c e - l o',
                 'z e 6 l g',
                 'H W l v R',
                 'q 9 m # o' ];
                
my $messages2=[ 'P + 2 l ! a t o ',
                '1 e 8 0 R $ 4 u ',
                '5 - r ] + a > / ',
                'P x w l b 3 k \ ',
                '2 e 3 5 R 8 y u ',
                '< ! r ^ ( ) k 0 ' ];    
                            
print "First set results   :-",collector($messages1),"\n";                 
print "Second set results  :-",collector($messages2),"\n";

# This solution extends the Task by creating a simulated broken messager
# and tests the decrypter by repeated sampling until stable.

print "\nTesting decoding of broken messages.  A message is sent repeatedly,
responses collected and attempt is made to decode based on available
results.  This continues until the results are stable.  This does not
always work of course. Randomness is such...\n\n";

tryUntilStable("Hi there matey!");   


# The routine that works on a collection of mangled messages and returns
# the most common characters for each position in the messages

sub collector{
	my $messages=shift;                               # the list ref of messages
    my $result="";                                    # the result to return
    
    foreach my $col (0.. length $$messages[0]){       # for each poition
		my %collection=();                            # hash to store frequencies 
		foreach my $message (@$messages){
			no warnings;                              # so that undef === 0
			$collection{(split //,$message)[$col]}++; # increment count when found
		}
		my $max=0; my $commonest="";                  # now search and find commonest
		foreach my $char (keys %collection){
			if ($collection{$char} > $max) {
				$max=$collection{$char};
				$commonest=$char;
			}
		}
		$result.=$commonest;                           # add the commonenst char to our result
	}
   return $result;
}

# simulates a broken messager.  The characters in the message are
# sent correctly or replaced by a random character.  How broken the
# messager is can be set by altering $brokenness

sub brokenMessager{
	my $message=shift;
	
	my $brokenness=0.4;                # likelihood of mangling
	
	my $allChars="";                   # a string of all printable chars
	$allChars .= chr for 1..255;       # First get all characters 0 to 255,
	$allChars =~s/[^!-~]//g;           # Then remove anything non printable
	
	my $result="";
	
	foreach my $char (split //,$message){    # split $message and random replace
		$result.=(rand()>$brokenness)?(split //,$allChars)[rand()*length $allChars]:$char;
	}
	return $result;
	
}

# Keep sending a message through the broken messager, and collect
# results.  Then test using collector().  When the result no longer
# changes we imagine that enough data has been collected to give a
# correct guess. This is not always true of course...

sub tryUntilStable{
	my $message=shift;
	my $tests=[];
	my $result=""; my $guess="A guess";
	while ($result ne $guess){
		$result=$guess;
		my $messageReceived=brokenMessager($message);
		print $messageReceived,"\n";
		sleep 0.5;
		push @$tests,$messageReceived;
		$guess=collector($tests);
	}
	
	print "\nFinal result:- $result\n"
	
	
}




