use v5.38;
##
# You are given an array of strings and a check string.
# Write a script to find out if the check string is the acronym of the words in the given 
# array.
##
use boolean;
sub acronym{
    my($strings, $acronym) = @_;
    return boolean(join(q//, map {(split //, lc $_)[0]} @{$strings}) eq lc $acronym);
}

MAIN:{
    say acronym [qw/Perl Python Pascal/], q/ppp/;
    say acronym [qw/Perl Raku/], q/rp/;
    say acronym [qw/Oracle Awk C/], q/oac/;
}