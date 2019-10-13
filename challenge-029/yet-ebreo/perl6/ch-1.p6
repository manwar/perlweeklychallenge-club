#!/usr/bin/env perl
# Write a script to demonstrate brace expansion. 
# For example, script would take command line argument 
# Perl {Daily,Weekly,Monthly,Yearly} Challenge and should expand it and print like below:
#   Perl Daily Challenge
#   Perl Weekly Challenge
#   Perl Monthly Challenge
#   Perl Yearly Challenge

sub MAIN (
    $string     #= String containing braces "{}" to expand
) {
    my $mstring = $string;
    $mstring~~s:g/\{\}//;
    expand($mstring);
}

sub expand ($string) {
    #The string will be stored in $string
    my $mstring = $string;

    #- Regex was used to check if the string contains matching braces
    #- Notice that [^{}]* instead of a simple .* to match the contents of the braces
    #      this is to make sure that the inner most brace is processed first
    #- The matching string was captured using () and will be stored in $1
    if ($mstring ~~ /\{(<-[{}]>*)\}/) {
        # The captured value, the prematch and postmatch were stored
        # in variables $l,$m and $r respectively
        my ($l,$m,$r) = ($/.prematch,$0,$/.postmatch);
        # The captured value stored in $m was split using comma(,) as delimiter
        # The resulting list was used in a for loop
        for ($m.split(",")) {
            #A new string containing the prematch, a value from the split operation of $m
            #and the postmatch will be used in the recursive function.
            #The process will be repeated until...
            expand($l~$_~$r);
        }
    } else {
        #The string does not have matching braces.
        #Then final string will be printed
        say $mstring;
    }
}