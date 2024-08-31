#!/usr/bin/perl
use v5.38;
use InputParsing;

my $input = <STDIN>;
my $lucky_int = find_largest_lucky_int(InputParsing::get_ints($input));
say $lucky_int;

sub find_largest_lucky_int {
    my %counts;
    $counts{$_}++ for @_;
    my @lucky_ints = grep { $counts{$_} == $_ } keys %counts;
    return @lucky_ints ? (sort { $b <=> $a } @lucky_ints)[0] : -1;
}

__END__
