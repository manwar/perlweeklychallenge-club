use strict;
use warnings;

sub find_odd_character {
    my ($s, $t) = @_;

    # Count characters in both strings
    my %count;
    $count{$_}++ for split //, $s;
    $count{$_}-- for split //, $t;

    # Find the character with count -1
    foreach my $char (keys %count) {
        return $char if $count{$char} == -1;
    }
}

# Tests
use Test::Simple tests => 3;
ok(find_odd_character("Perl", "Preel") eq "e", 'Test Example 1');
ok(find_odd_character("Weekly", "Weeakly") eq "a", 'Test Example 2');
ok(find_odd_character("Box", "Boxy") eq "y", 'Test Example 3');
