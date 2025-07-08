#!/usr/bin/env perl
use Modern::Perl;
use experimental qw(signatures);
use Test::More;

sub is_nice_string ($string) {
    my %lowers = (
        map {$_ => 1}
        $string =~ /([a-z])/g
    );
    my %uppers = (
        map {$_ => 1}
        $string =~ /([A-Z])/g
    );

    return uc(join(q(), sort keys %lowers)) eq join(q(), sort keys %uppers);
}

sub find_longest_nice_substring ($string) {
    my $length = length($string);
    my @substrings;
    for my $start (0 .. $length - 2) {
        for my $substr_length (2 .. $length - $start) {
            push @substrings, substr($string, $start, $substr_length);
        }
    }
    
    my $longest_nice_substring = (
        sort {$b->[0] <=> $a->[0]}
        map {[length($_), $_]}
        grep {is_nice_string($_)}
        @substrings
    )[0];

    return $longest_nice_substring ? $longest_nice_substring->[1] : q();
}

ok(is_nice_string('aA'));
ok(is_nice_string('abAB'));
ok(is_nice_string('aAbB'));
ok(is_nice_string('aaaAbaB'));
ok(!is_nice_string('a'));
ok(!is_nice_string('A'));
ok(!is_nice_string('aB'));
ok(!is_nice_string('bA')); 

is(find_longest_nice_substring('YaaAho'), 'aaA');
is(find_longest_nice_substring('cC'), 'cC');
is(find_longest_nice_substring('guuhUHarto'), 'uuhUH');
is(find_longest_nice_substring('abababAB'), 'abababAB');
is(find_longest_nice_substring('A'), '');
is(find_longest_nice_substring('ABC'), '');

done_testing();
