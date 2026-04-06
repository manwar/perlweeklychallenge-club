#!/usr/bin/perl
use strict;
use warnings;

=head1

This solution concerns about:

- readability
- maintainability

and may said to be intentionally conservative:

- C-style loops
- step-by-step logic
- no Perl magic with map/grep, $_, dense expressions

In short: I'am choosing clarity on purpose. Maybe sometimes less performant.

=cut

sub step1 {
    my @res;
    my ($list1, $list2) = @_;

    for (my $i = 0; $i < scalar(@$list1); $i++) {
        for (my $j = 0; $j < scalar(@$list2); $j++) {
            if ($list1->[$i] eq $list2->[$j]) {
                push @res, ($i + $j) . " $list1->[$i]";  # store sum + value

            }
        }
    }

    return @res;
}

sub step2 {
    my @res = @_;
    for (my $i = 0; $i < scalar(@res); $i++) {
        my @match = grep { $_ == $i } @res;
        return @match if @match;
    }
    return; # no match found
}

sub step3 {
    my @r2;

    for (my $i = 0; $i < scalar(@_); $i++) {
        my @r = split / /, $_[$i];
        push @r2, $r[1] if defined $r[1];
    }

    return @r2;
}

sub minimum_index {
    my ($list1, $list2) = @_;
    return step3(step2(step1($list1, $list2))); # nice pipeline!
}

# Tests

my @list1;
my @list2;

# Example 1
@list1 = ("Perl", "Raku", "Love");
@list2 = ("Raku", "Perl", "Hate");
print minimum_index(\@list1, \@list2), "\n"; # Perl, Raku

# Example 2
@list1 = ("A", "B", "C");
@list2 = ("D", "E", "F");
print minimum_index(\@list1, \@list2), "\n"; # ()

# Example 3
@list1 = ("A", "B", "C");
@list2 = ("C", "A", "B");
print minimum_index(\@list1, \@list2), "\n"; # ("A")
