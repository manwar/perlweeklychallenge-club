use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

my %mapping = ('G' => 'G', '()' => 'o', '(al)' => 'al');

sub run($str) {
    my $result = "";
    foreach my $m ( $str =~ m/(G|\([^\(\)]*\))/g ) {
        $result .= $mapping{$m};
    }
    return $result;
}

is(run('G()(al)'), 'Goal', 'Example 1');
is(run('G()()()()(al)'), 'Gooooal', 'Example 2');
is(run('(al)G(al)()()'), 'alGaloo', 'Example 3');
is(run('()G()G'), 'oGoG', 'Example 4');
is(run('(al)(al)G()()'), 'alalGoo', 'Example 5');
