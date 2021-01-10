#!/usr/bin/perl
# The Weekly Challenge 094
# Task 1 Group Anagrams
# Usage: ch-1.pl [@S]
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
# unicode info:
# 0. http://blogs.perl.org/users/c_y_fung/
#    2021/01/from-a-reflection-on-the-weekly-challenge-092-task-1.html
# 1. https://stackoverflow.com/questions/15210532/use-of-use-
#    utf8-gives-me-wide-character-in-print
# 2. https://www.reddit.com/r/perl/comments/koahhf/
#    from_a_reflection_on_the_weekly_challenge_092/


my %hash_num;

sub collect_alphabets {
    my @words = @_;
    my @alphabets = split //, join("" , @words); 
    my $i = 0;
    for (@alphabets) {
        if (!exists $hash_num{$_}) { 
            $hash_num{$_} = $i++;
        }
    }
}

sub learn_atoms {
    my $word = $_[0];
    my @alphabets = split //, $word;
    my @coord = map {$hash_num{$_}} @alphabets;
    @coord = sort @coord;
    return join ",", @coord;
}

sub compare_two_words {       # a testing function
    return learn_atoms($_[0]) eq learn_atoms($_[1]) ? 1 : 0; 
}

collect_alphabets(@ARGV);

my %hash_compounds;
my @arr;
my $k = 0;

for my $w (@ARGV) {
    my $l = learn_atoms($w);
    if (!exists $hash_compounds{$l}) {
        $hash_compounds{$l} = $k; 
        $arr[$k] = [$w];
        $k++;
    } 
    else {
        push @{$arr[ $hash_compounds{$l} ]}, $w;
    }
}

$k--;

for my $j (0..$k) {
    print "(\"";
    print join "\",\"", @{$arr[$j]};
    print "\")\n"; 
}

