use v5.36;
##
# You are given two arrays of strings.
# Write a script to find out if the word created by concatenating the array elements is 
# the same.
##
use boolean;
sub same_string{
    my($a1, $a2) = @_;
    return boolean(join(q//, @{$a1}) eq join(q//, @{$a2}));
}

MAIN:{
    say same_string [qw/ab c/], [qw/a bc/];
    say same_string [qw/ab c/], [qw/ac b/];
    say same_string [qw/ab cd e/], [qw/abcde/];
}