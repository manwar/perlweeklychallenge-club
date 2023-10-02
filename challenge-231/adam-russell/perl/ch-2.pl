use v5.38;
##
# You are given a list of passenger details in the form “9999999999A1122”, where 9 denotes 
# the phone number, A the sex, 1 the age and 2 the seat number.
# Write a script to return the count of all senior citizens (age >= 60).
##
sub count_senior_citizens{
    my $count = 0;
    do{
        my @a = unpack q/A10A1A2A2/, $_; 
        $count++ if $a[2] >= 60;
    } for @_;
    return $count;
}

MAIN:{
    say count_senior_citizens qw/7868190130M7522 5303914400F9211 9273338290F4010/;
    say count_senior_citizens qw/1313579440F2036 2921522980M5644/;
}