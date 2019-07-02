#!/usr/bin/env perl

use v5.22;

#TASK: imlement a vigenere cipher.

my $usage =<<"USAGE";
$0  encode|decode key [message]

  Encodes or decodes the message given at the command line. 
  Requires a key to be passed in after the command.

  With no message given, enters REPL mode, 
  encoding/decoding the input, one line at a time.
USAGE

#pull of the arguments. We need to shift them so <> works later
my ($command, $key, $message) = (shift, shift, shift);


#we use one list to represent the table, so we can get the start
#value and the length
my @abc;
#we use all printable ascii characters... 'cause we can
push @abc, $_ for ord(' ') .. ord('~');

#we take each letter from the message to en/decode, and then get
#the correct letter from the cipher, and pass it to a callback
#which does the shifting
sub vignere_loop {
  my @encrypted;
  my ($message, $cb) = @_;
  for my $letter (split //, $message) {
    #keep a local copy of where we're holding in the key
    state $key_index = 0;
    $key_index %= length $key;
    #get the letter at our position
    my $cipher = substr $key, $key_index, 1;

    push @encrypted, $cb->($cipher, $letter);
    $key_index++;
  }
  @encrypted
}

sub letter_by_offset {
  my $offset = shift;
  chr( $offset % @abc + $abc[0] )
}

sub offset {
  ord(shift) - $abc[0]
}
  

my %execute;
$execute{encode} = sub {
  vignere_loop shift, sub {
    my ($cipher, $letter) = @_;
    letter_by_offset( offset($letter) + offset($cipher) )
  };
};

$execute{decode} = sub {
  vignere_loop shift, sub {
    my ($cipher, $letter) = @_;
    letter_by_offset( offset($letter) - offset($cipher) );
  };
};

#i recently found out that you can take a reference to a function
#inside of an interpolation, so it's creeping in everywhere I
#write code
sub die_usage { die "${\shift} \n $usage" }

#CLI app parameter checking
die_usage "Command required" unless $command;
#we check for available commands dynamically so that we DRY
die_usage "Unrecognized command: $command" 
   unless grep { $command eq $_ } keys %execute;
die_usage "Need a key in order to $command" unless $key;

#either process this one, or enter the REPL
if ($message) {
  #in case the message has a space, pull the rest off of ARGV
  say $execute{$command}->(join ' ', $message, @ARGV);
} else {
  say "Now entering REPL mode, press CTRL-D to finish";
  while (<>) {
    say $execute{$command}->($_)
  }
}

