#!/usr/bin/env perl
use strict;
use warnings;
use Math::BigInt;

# Decimal strings keep unbounded inputs out of native floating arithmetic.
sub divisible_average {
    my (@values) = @_;
    my $sum = Math::BigInt->bzero();
    my $count = Math::BigInt->bzero();

    for my $text (@values) {
        die "Expected positive decimal integers\n"
            if !defined($text) || ref($text)
            || $text !~ /\A[0-9]+\z/ || $text !~ /[1-9]/;
        $text =~ s/\A0+//;
        my $value = Math::BigInt->new($text);
        next unless $value->copy()->bmod(6)->is_zero();
        $sum->badd($value);
        $count->binc();
    }
    return '0' if $count->is_zero();

    my $quotient = $sum->copy()->bdiv($count);
    my $remainder = $sum->copy()->bmod($count);
    # The task leaves half ties unspecified; this implementation rounds them up.
    $quotient->binc() if $remainder->bmul(2)->bcmp($count) >= 0;
    return $quotient->bstr();
}

sub divisible_average_cli {
    if (@_ == 1 && $_[0] eq '--help') {
        print "Usage: perl ch-1.pl [POSITIVE_DECIMAL ...]\n";
        return 0;
    }
    my $answer = eval { divisible_average(@_) };
    if ($@) {
        print STDERR "Error: $@";
        return 2;
    }
    print "$answer\n";
    return 0;
}

exit divisible_average_cli(@ARGV) unless caller;
1;

__END__

=head1 NAME

ch-1.pl - Exact divisible average for Weekly Challenge 398

=head1 DESCRIPTION

Accept positive decimal integer strings and average the multiples of six using
Math::BigInt. Return a nearest integer, choosing upward at an exact half tie.
Return zero when no input qualifies, including the declared empty-array extension.
The callable divisible_average function is shared by CLI and batch validation.

Original work by ItsMeSamey with OpenAI Codex assistance. MIT licensed.

=cut
