#!perl6 
# Task 2 Challenge 050 Solution by kevincolyer
# Contributed by Ryan Thompson.Noble Integer
# You are given a list, @L, of three or more random integers between 
# 1 and 50. A Noble Integer is an integer N in @L, such that there 
# are exactly N integers greater than N in @L. Output any Noble 
# Integer found in @L, or an empty list if none were found.
# An interesting question is whether or not there can be multiple 
# Noble Integers in a list.
# For example,
# Suppose we have list of 4 integers [2, 6, 1, 3].
# Here we have 2 in the above list, known as Noble Integer, since 
# there are exactly 2 integers in the list i.e.3 and 6, which are 
# greater than 2.
# Therefore the script would print 2.

use Test;

# helper sub
sub generateIntegerLists() {
    my @list = (1..50).roll xx (3+(0..17).roll);
}


sub filterNobelIntegers(@set) {
    return if @set.elems < 3;
    # reverse the list because if there are two items greater than N then N must == 2 to be a nobel number
    # which is the index of the array item becing checked
    # for once zero indexed arrays work for us!
    my @ordered = @set.sort.reverse;
    my @ni;
    for 1..^@set.elems -> $i {
        if @ordered[$i]==$i  { @ni.append: @ordered[$i] };
    }
    return @ni;
}

# Tests
is filterNobelIntegers([2, 6, 1, 3]),(2),"Nobel int found in example";
is filterNobelIntegers([5, 6, 8, 3]),(3),"Nobel int found";
is filterNobelIntegers([5, 6, 8, 3,3]),(3),"Nobel int found";
is filterNobelIntegers([5, 6, 8, 3,3,3]),(3),"Nobel int found";
done-testing;

# take 20 random sets and search for Nobel Integers
for ^20 {
    my @a = generateIntegerLists();
    my @ni=filterNobelIntegers(@a);
    
    print @ni.elems > 0 ?? "* " !! "  ";
    print "[{@a.sort}] does ";
    print "not " if @ni.elems==0;
    say "have a nobel integer(s) [{@ni}]";
}
