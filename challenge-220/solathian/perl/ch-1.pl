#!usr/bin/perl
use v5.36;
use builtin qw(indexed);
no warnings 'experimental';

# Challenge 220 - 1 - Common Characters
# You are given a list of words.
# Write a script to return the list of common characters (sorted alphabeticall) found in every word of the given list.

cc("Perl", "Rust", "Rakur");    # r
cc("love", "live", "leave");  # ("e", "l", "v")

sub cc(@wordArray)
{
    my %resultHash;
    my @results;
    
    die("Not enough words are given")   if( @wordArray <= 2);
    
    foreach my ($index, $word) (indexed @wordArray)
    {
        foreach my $char ($word =~ /(.)/g)
        {
            $char = lc $char;
            
            if( (not defined  $resultHash{$char}) && ($index == 0))
            {
                $resultHash{$char} = 1;
            }
            
            # this way it will be only incremented once
            elsif( defined($resultHash{$char}) && ($resultHash{$char}  == $index) )  
            {
                $resultHash{$char}++;
            }

        }

    }
    
    # collect and print the results
    foreach my ($key, $value) (%resultHash)
    {
        push(@results, $key)    if($value == @wordArray);   # so it is in all of the words
    }
    
    say join(',', sort @results);
}