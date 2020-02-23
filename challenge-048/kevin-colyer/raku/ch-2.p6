#!perl6 
# Task 2 Challenge 048 Solution by 
# 
# Palindrome Dates
# 
# Write a script to print all Palindrome Dates between 2000 and 2999. The 
# format of date is mmddyyyy. For example, the first one was on October 2, 
# 2001 as it is represented as 10022001.
#

# Set up a custom string formatter to convert the date to the correct us format (see docs)
my $pwcformat= sub ($self) { sprintf "%02d%02d%04d", .month, .day, .year given $self;};

# Construct date object using custom formatter
my $date=Date.new(year => 2001,month=>10,day=>2, formatter => $pwcformat);
my $end=Date.new(year => 3000,month=>1,day=>1);

while $date < $end {
    my $d=$date.Str;
    say $date.yyyy-mm-dd ~ " is palindrome: $d" if $d eq $d.flip;
    $date.=succ;
}
