use strict;
use warnings;

#You are given a text file name $file and range $A - $B where $A <= $B.
#
#Write a script to display lines range $A and $B in the given file.
#
#Example
#Input:
#    $ cat input.txt
#    L1
#    L2
#    L3
#    L4
#    ...
#    ...
#    ...
#    ...
#    L100
#$A = 4 and $B = 12
#Output:
#    L4
#    L5
#    L6
#    L7
#    L8
#    L9
#    L10
#    L11
#    L12


#Must accept three arguments
if ($#ARGV != 2){
  die "Error of arguments: ch-2.pl <file_name> <A> <B>";
}

my $file_name = $ARGV[0];
my $A = $ARGV[1];
my $B = $ARGV[2];
my $count;

#In case is needed to create the file and filing it
#createFile();
sub createFile {
    foreach (my $i=1; $i<=100; $i++){
        open (F, ">>$file_name") || die "Could not open file: $!\n";
        print F "L$i\n";
        close F;
    }
}

#First we check that the file exists
if  ( !-f $file_name) {
    die "the file $file_name doesn't exist\n";
}

#We check $A <= $B
if ($A >= $B) {
    die "$A isn't smaller that $B\n";
}

printLines();

sub printLines {
    
    open(FILE, $file_name) or die "Could not read from $file_name\n";

    $count = 1;
    while (<FILE>) {
        if ($count > $B) {
            close FILE;
            exit;
        }
        if ($count >= $A) {
            print $_;
        }
      $count++;
    }
}

