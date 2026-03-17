use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

my %chars;
my $char_index = 0;

foreach my $c ("a" .. "z") {
    $char_index += 1;
    $chars{$char_index} = $c;
}

sub run($str) {
    my $result = "";
    while (length($str) > 0) {
        my $value_end = 1;
        my $next_start = 1;
        if ($str =~ /^\d{2}#/) {
            $value_end = 2;
            $next_start = 3;
        }
        $result .= $chars{substr($str, 0, $value_end)};
        $str = substr($str, $next_start);
    }
    return $result;
}

is(run('10#11#12'), 'jkab', 'Example 1');
is(run('1326#'), 'acz', 'Example 2');
is(run('25#24#123'), 'yxabc', 'Example 3');
is(run('20#5'), 'te', 'Example 4');
is(run('1910#26#'), 'aijz', 'Example 5');
