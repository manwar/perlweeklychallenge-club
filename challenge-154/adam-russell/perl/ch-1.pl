use strict;
use warnings;
##
# You are given possible permutations of the string "PERL".
# Write a script to find any permutations missing from the list.
##
use Algorithm::Loops q/NestedLoops/;

sub factorial{
    my($n) = @_;
    return 1 if $n == 1;
    $n * factorial($n - 1);
}

sub missing_permutations{
    my($permutations, $s) = @_;
    my @missing;
    ##
    # remove any duplicates
    ##
    my %permutations;
    map {$permutations{$_}=undef} @{$permutations};    
    $permutations = [keys %permutations];
    ##
    # get the letters missing in each slot
    ##
    my @missing_letters;
    for my $i (0 .. length($s) - 1){
        my %slot_counts;
        my @ith_letters = map {my @a = split(//, $_); $a[$i]} @{$permutations};
        map{$slot_counts{$_}++} @ith_letters;
        $missing_letters[$i] = [grep {$slot_counts{$_} != factorial(length($s) - 1)} keys %slot_counts];
    }
    ##
    # determine which missing letters form missing permutations
    ##
    my $nested = NestedLoops(\@missing_letters);
    while (my @set = $nested->()){
        my $candidate = join("", @set);
        my @matched = grep {$candidate eq $_} @{$permutations};
        push @missing, $candidate if !@matched;
    }
    return @missing;
}


MAIN:{
    my @missing = missing_permutations(
        ["PELR", "PREL", "PERL", "PRLE", "PLER", "PLRE", "EPRL", "EPLR", "ERPL",
         "ERLP", "ELPR", "ELRP", "RPEL", "RPLE", "REPL", "RELP", "RLPE", "RLEP",
         "LPER", "LPRE", "LEPR", "LRPE", "LREP"], "PERL"
    );
    print join(", ", @missing) . "\n";
}