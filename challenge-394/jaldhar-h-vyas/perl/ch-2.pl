#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($str1, $str2, $str3) = @ARGV;

my @characters = split //, $str1;
my %longest;
my $longestLength = 0;

for my $start (keys @characters) {
    my $previousCategory;

    for my $end ($start .. scalar @characters - 1) {
        my $category = (lc $characters[$end]) =~ /[aeiou]/
            ? 'vowel'
            : 'consonant';

        if (defined $previousCategory && $category eq $previousCategory) {
            last;
        }
        $previousCategory = $category;

        my $candidate = join q{}, @characters[$start .. $end];
        unless ($str2 =~ /$candidate/ && $str3 =~ /$candidate/) {
            next;
        }

        my $length = $end - $start + 1;
        if ($length > $longestLength) {
            %longest = ($candidate => true);
            $longestLength = $length;
        } elsif ($length == $longestLength) {
            $longest{$candidate} = true;
        }
    }
}

say q{(} . (join q{, }, map { "\"$_\"" } sort keys %longest) . q{)};
