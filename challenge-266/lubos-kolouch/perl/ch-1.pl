use strict;
use warnings;


sub uncommon_words {
    my ($line1, $line2) = @_;
    
    my %count1 = map { $_ => scalar(() = $line1 =~ /\b$_\b/g) } split ' ', $line1;
    my %count2 = map { $_ => scalar(() = $line2 =~ /\b$_\b/g) } split ' ', $line2;

    my @result;
    foreach my $word (keys %count1) {
        push @result, $word if $count1{$word} == 1 and not exists $count2{$word};
    }
    foreach my $word (keys %count2) {
        push @result, $word if $count2{$word} == 1 and not exists $count1{$word};
    }

    return @result ? @result : ('');
}

# Test cases
use Test::More tests => 3;
is_deeply([uncommon_words('Mango is sweet', 'Mango is sour')], ['sweet', 'sour'], 'Example 1');
is_deeply([uncommon_words('Mango Mango', 'Orange')], ['Orange'], 'Example 2');
is_deeply([uncommon_words('Mango is Mango', 'Orange is Orange')], [''], 'Example 3');

1;
