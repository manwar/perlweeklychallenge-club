#!usr/bin/perl
use v5.36;

# Challenge 224 - 1 - Special Notes

# You are given two strings, $source and $target.
# Write a script to find out if using the characters (only once) from source, a target string can be created.

sn("abc", "xyz");                       # false
sn("scriptinglanguage", "perl");        # true
sn("aabbcc", "abc");                    # true


sub sn($source, $target)
{
    my $retVal  = "true";
    
    # create arrays from the strings
    my @source  = split(//, $source);
    my @target  = split(//, $target);
    
    
    # build hash
    my %source;
    foreach my $elem (@source)
    {
        $source{$elem}++;
    }
    
    # check the target against the hash, decrase counter if needed, remove elements if 0 is reached
    foreach my $targetChar (@target)
    {
        if(exists $source{$targetChar})
        {
            $source{$targetChar}--;
            
            delete $source{$targetChar}       if($source{$targetChar} == 0)

        }
        else
        {
            $retVal = "false";
            last;
        }
    }
    
    say $retVal;

}