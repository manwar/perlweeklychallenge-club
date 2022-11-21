#!/usr/bin/perl
use 5.030;
use warnings;
use English;

sub isCute {
    my ($list) = @_;
    my $i = 1;

    for my $elem (@{$list}) {
        if ($i % $elem && $elem % $i) {
            return undef;
        }
        $i++;
    }

    return 1;
}

sub permute (&@) {
    my $code = shift;
    my @idx = 0..$#_;
    while ( $code->(@_[@idx]) ) {
        my $p = $#idx;
        --$p while $idx[$p-1] > $idx[$p];
        my $q = $p or return;
        push @idx, reverse splice @idx, $p;
        ++$q while $idx[$p-1] > $idx[$q];
        @idx[$p-1,$q]=@idx[$q,$p-1];
    }
}

sub usage {
print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <n>
  
    <n>    integer from 1 to 15 inclusive
-USAGE-
    exit(0);
}

my $n = shift // usage;

if ($n <= 0 || $n >= 16) {
    usage;
}

 my @perms;
permute { push @perms, \@_; } (1 .. $n);

say scalar grep { isCute($_) } @perms;
