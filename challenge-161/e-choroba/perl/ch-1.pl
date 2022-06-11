#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };
use Syntax::Construct qw{ // };

my @disordered;
my $previous = 'a';
for my $char ('b' .. 'z') {
    push @disordered, "$char" . '[' . join("", 'a' .. $previous) . ']';
    $previous = $char;
}

my $disordered = join '|', map "(?:$_)", @disordered;

sub abecedarian_words {
    my ($dictionary) = @_;
    my @abcd;
    open my $in, '<', $dictionary or die $!;
    while (my $word = <$in>) {
        chomp $word;
        push @abcd, $word if $word !~ /$disordered/;
    }
    @abcd = sort { length $b <=> length $a } @abcd;
    return @abcd
}

say for abecedarian_words(shift // 'dictionary.txt');

# See also 111/2.
