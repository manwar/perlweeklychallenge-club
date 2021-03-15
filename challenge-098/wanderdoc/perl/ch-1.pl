#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given file $FILE. Create subroutine readN($FILE, $number) returns the first n-characters and moves the pointer to the (n+1)th character.
Example:
Input: Suppose the file (input.txt) contains "1234567890"
Output:
    print readN("input.txt", 4); # returns "1234"
    print readN("input.txt", 4); # returns "5678"
    print readN("input.txt", 4); # returns "90"

=cut






use FindBin qw($Bin); # Windows.
use IO::File; 
use feature 'state';



sub readN
{
     my ($file, $num) = @_;
     state $handle = (IO::File->new("$Bin/$file", "r") or die "$!");
     my $into;
     read($handle, $into, $num);
     return $into;
}
print readN("input.txt", 4), $/; # 1234
print readN("input.txt", 4), $/; # 5678
print readN("input.txt", 4), $/; # 90