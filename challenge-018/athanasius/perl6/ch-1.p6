use v6;

################################################################################
=begin comment

Perl Weekly Challenge 018
=========================

Task #1
-------

Write a script that takes 2 or more strings as command line parameters and print
the longest common substring. For example, the longest common substring of the
strings "ABABC", "BABCA" and "ABCBA" is string "ABC" of length 3. Other common
substrings are "A", "AB", "B", "BA", "BC" and "C". Please check this
[ https://en.wikipedia.org/wiki/Longest_common_substring_problem |wiki page] for
details.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

sub MAIN
(
    Str:D $string1,
	Str:D $string2,
		 *@strings3-n
)
{
    my @strings = $string1, $string2;
       @strings.append: @strings3-n;

    my @sets;
       @sets.push: get-substrings($_) for @strings;

    # The set of common substrings is the intersection of all the substring sets

    my Set $common-substrings = @sets[0];
           $common-substrings = $common-substrings ∩ @sets[$_]
                for 1 .. @sets.elems - 1;

    if $common-substrings.elems == 0
    {
        say "\nNo common substrings found";
    }
    elsif (my @solutions = get-solutions($common-substrings)) == 1
    {
        say "\nThe longest common substring is: \"{ @solutions[0] }\"";
    }
    else
    {
        say "\nThe { @solutions.elems } longest common substrings are: ",
             @solutions.sort.map({ qq["$_"] }).join(', ');
    }
}

sub get-substrings
(
    Str:D $string
--> Set:D
)
{
    my      @substrings;
    my UInt $max-index = $string.chars - 1;

    for 0 .. $max-index -> UInt $start-index
    {
        for 1 .. ($max-index - $start-index + 1) -> UInt $length
        {
            @substrings.push: $string.substr($start-index, $length);
        }
    }

    return @substrings.Set;
}

sub get-solutions
(
    Set:D $substrings
--> List:D
)
{
    my @sorted     = $substrings.keys.sort({ $^b.chars cmp $^a.chars });
    my @solutions  = @sorted.shift;
    my $max-length = @solutions[0].chars;

    while (my $element = @sorted.shift)
    {
        if $element.chars == $max-length
        {
            @solutions.push: $element;
        }
        else
        {
            last;
        }
    }

    return @solutions;
}

################################################################################
