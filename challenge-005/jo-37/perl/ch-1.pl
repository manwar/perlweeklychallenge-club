#!/usr/bin/perl

use v5.26;
use Getopt::Long;
use warnings;
use autodie;
use experimental 'signatures';

use constant DICT => '/usr/share/dict/words';
use List::MoreUtils 'frequency';
use List::Util 'uniqstr';

### Options and Arguments

my ($tests, $examples, $verbose, $dict);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'dict=s'  => \$dict,
) or usage();
$dict //= DICT;

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - anagrams

    usage: $0 [-dict DICT] [WORD]

    -dict DICT
        use DICT as dictionary. Default: @{[DICT]}

    WORD
        a word

    EOS
}


### Input and Output

say "@{[anagrams(shift, $dict)]}";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/06/ch-005.html#task-1

sub anagrams ($word, $dict) {
    my %freq = frequency split //, $word;
    my $re = '';
    $re .= "(?=(?:[^$_]*+[$_]){$freq{$_}}[^$_]*+\$)" for keys %freq;
    my $full = ".{" . length($word) . "}";
    open my $words, '<', $dict;
    my @anagrams;
    while (<$words>) {
        chomp;
        push @anagrams, lc if /^$re$full$/i;
    }
    close $words;
    uniqstr @anagrams;
}

