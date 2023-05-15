use strict;
use warnings;
use feature 'say';

sub included {
    my @words = @{$_[0]};
    my $reg = lc $_[1];
    # say @words;
    my @letters = grep { /[a-z]/ } split //, $reg;
    # say @letters;
    my @result;
    for my $wd (@words) {
        my %wd_lets = map { $_ => 1 } split //, $wd;
        my @missing = grep { not exists $wd_lets{$_} } @letters;
        push @result, $wd if scalar @missing == 0;
    }
return @result;
}
my @tests = (
    {words => ['abc', 'abcd', 'bcd'], reg => 'AB1 2CD'},
    {words => ['job', 'james', 'bjorg'], reg => '007 JB'},
    {words => ['crack', 'road', 'rac'], reg => 'C7 RA2'}
    );
for my $test (@tests) {
    printf "%-30s", "@{$test->{words}} - $test->{reg} => ";
    say join " ", included $test->{words}, $test->{reg};
}
