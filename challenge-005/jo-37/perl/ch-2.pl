#!/usr/bin/perl

use v5.26;
use Getopt::Long;
use warnings;
use autodie;
use experimental 'signatures';

use constant DICT => '/usr/share/dict/words';
use List::UtilsBy 'max_by';
use List::Util 'uniqstr';
use List::MoreUtils 'frequency';


### Options and Arguments

my ($tests, $examples, $verbose, $dict);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'dict=s'  => \$dict,
) or usage();
$dict //= DICT;


usage() if @ARGV;

sub usage {
    die <<~EOS;
    $0 - maximum number of anagrams

    usage: $0 [-dict DICT]

    -dict DICT
        use DICT as dictionary. Default: @{[DICT]}

    EOS
}


### Input and Output

say most_anagrams($dict);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/06/ch-005.html#task-2

sub most_anagrams ($dict) {
    open my $words, '<', $dict;
    my @all = <$words>;
    close $words;
    chomp @all;
    my @words = map join('', sort split //), uniqstr map lc, @all;
    my %words = frequency @words;
    max_by {$words{$_}} keys %words;
}

