#!usr/bin/perl -w

# Created for perl weekly challenge - 182 - 2

# Given a list of absolute Linux file paths, determine the deepest path to the directory that contains all of them.

use strict;
use warnings;

use feature 'say';
use Data::Dumper;
   

use constant
{
    FALSE => 0,
    TRUE  => 1
};
    
# sample calls

# my @sampleArray = qw(    
                        # /a/b/c/1/x.pl
                        # /a/b/c/d/e/2/x.pl
                        # /a/b/c/d/3/x.pl
                        # /a/b/c/4/x.pl
                        # /a/b/c/d/5/x.pl
                    # );
    
# maxPath(\@sampleArray);

# my @sampleArray = (4, 2, 3, 1, 5, 0);
# maxIndex(\@sampleArray);

# my @sampleArray = (4, 2, 3, 5, 5, 0);
# maxIndex(\@sampleArray);

# my @sampleArray = (12, 12, 3, 5, 5, 0);
# maxIndex(\@sampleArray);


sub maxPath
{
    my ($arrayRef)  = @_;
    my @PathArray;
    my $currentDir = undef;
    my $endFlag     = FALSE;
    
    my @commonPathArr;


    # initialization
    foreach my $path (@$arrayRef)
    {
        # cut the file, remove starting and ending '/'s
        $path =~ s/^\/(.*)\/.*$/$1/;
        
        my @tempArray = split("/", $path);
        
        push(@PathArray, \@tempArray);
    }


    my $numberOfInputs = @PathArray;
    my $j=0;
    
    while($endFlag == FALSE)
    {
        for(my $i = 0; $i < $numberOfInputs; $i++)
        {
            # if we are just starting set the path
            if(not defined $currentDir)
            {
                $currentDir = $PathArray[$i][$j];
                next;
            }
            
            #indicate that this is not common, break loop
            if($currentDir ne $PathArray[$i][$j])
            {
                $endFlag = TRUE;
                last;
            }

        }
        
        # do not do these steps if we have to exit
        if($endFlag != TRUE)
        {
            push( @commonPathArr, $currentDir);
            $currentDir = undef;
            $j++;
        }

    }

    say("/", join("/",  @commonPathArr ));

   

}
