#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Str);

=head1 NAME

ch-1.pl - Count Vowel

=head1 DESCRIPTION

Given a string, return all possible vowel substrings. A vowel substring
is a substring that only consists of vowels and has all five vowels present.

=cut

my $STR_CHECK = compile(Str);

sub count_vowel ($str) {
    ($str) = $STR_CHECK->($str);
    my @chars = split //, $str;
    my @results;

    for my $i (0 .. $#chars) {
        next unless $chars[$i] =~ /[aeiou]/;
        my %seen;
        for my $j ($i .. $#chars) {
            last unless $chars[$j] =~ /[aeiou]/;
            $seen{$chars[$j]} = 1;
            if (keys %seen == 5) {
                push @results, substr($str, $i, $j - $i + 1);
            }
        }
    }
    return @results;
}

sub _run_cli (@args) {
    if (!@args) { _run_tests(); return; }
    die "Usage: perl $0 <string>\n" if @args != 1;
    my $str = $args[0];
    my @out = count_vowel($str);
    say qq{Input: \$str = "$str"};
    say "Output: (" . join(", ", map { qq{"$_"} } @out) . ")";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'aeiou',
          expected => ['aeiou'] },
        { label => 'Example 2', str => 'aaeeeiioouu',
          expected => ['aaeeeiioou','aaeeeiioouu','aeeeiioou','aeeeiioouu'] },
        { label => 'Example 3', str => 'aeiouuaxaeiou',
          expected => ['aeiou','aeiouu','aeiouua','eiouua','aeiou'] },
        { label => 'Example 4', str => 'uaeiou',
          expected => ['uaeio','uaeiou','aeiou'] },
        { label => 'Example 5', str => 'aeioaeioa',
          expected => [] },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my @got = count_vowel($case->{str});
        Test::More::is_deeply(\@got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
