#!usr/bin/perl
use v5.36;
use builtin 'indexed';
no warnings 'experimental';

# Challenge 208 - 2 - Minimum Index Sum
# You are given two arrays of strings.
# Write a script to find out all common strings in the given two arrays with minimum index sum. 
# If no common strings found returns an empty list.



my @list0 = ("Perl", "Raku", "Love");
my @list1 = ("Raku", "Perl", "Hate");
minIndSum(\@list0, \@list1);


my @list2 = ("A", "B", "C");
my @list3 = ("D", "E", "F");
minIndSum(\@list2, \@list3);


my @list4 = ("A", "B", "C");
my @list5 = ("C", "A", "B");
minIndSum(\@list4, \@list5);

sub getIndex($target, $arrayRef)
{
    my $retVal = -1;
    
    foreach my ($i, $value) (indexed @$arrayRef)
    {
        if($value eq $target)
        {
            $retVal = $i;
            last;
        }
    }
    
    die "getIndex would return with -1"  if($retVal == -1);
    
    return $retVal;
    
}

sub minIndSum($list0, $list1)
{

    my @common;
    
    OUTER:
    foreach my $first (@$list0)
    {
        foreach my $second (@$list1)
        {
            if($first eq $second)
            {
                push(@common, $first);
                next OUTER;
            }
        }
    }
    
    if(@common == 0)
    {
        return -1;
        say("No common string found, so no result.");
    }
    foreach my $commonWord (@common)
    {
        my $i0   = getIndex($commonWord, $list0);
        my $i1   = getIndex($commonWord, $list1);
        my $sum  = $i0 + $i1;

        say("Index sum of \"$commonWord\":\t $i0 + $i1 = $sum" );
    }
    
    

}