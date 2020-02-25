#!/usr/env/perl 
# Challenge 046 Task #1
# The square secret code mechanism first removes any space from the original message.
# Then it lays down the message in a row of 8 columns. The coded message is then
# obtained by reading down the columns going left to right.
# Write a script that accepts a message from command line and prints the equivalent coded message.

# This extends the task by allowing any number of columns, with default of 8

my $stringToEncode=$ARGV[0]//"The quick brown fox jumps over the lazy dog";
my $cols=$ARGV[1]//8;

print pivotEncode($stringToEncode,$cols),"\n";

# Sub routine pivotEncode; Takes a string to encode and an optional
# number of columns (default 8); returns encoded string

sub pivotEncode{
   my $str=shift;
   my $cols=shift//8;
   $str=~s/\s//gm;                             # remove spaces
   @splitChars=($str=~/(.{$cols}|.+)/g);       # split into blocks
   my $result;                                 # initialise result
   foreach my $index (0..$cols-1) {            # now select character    
      foreach my $row ( @splitChars ){         # in each block and
		                                       # append it to result
        $result.= substr($row,$index,1) if ($index<length $row)
      }
      $result.=" ";                            #intersperse spaces
   }
   return $result;                             # return encrypted
}
