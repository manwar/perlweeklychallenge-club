#!/usr/bin/env perl
#
# ch-1.pl - Abecedarian words
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
use autodie;
no warnings 'uninitialized';

use Getopt::Long;
use File::Slurper qw< read_lines >;
use Benchmark qw<cmpthese :hireswallclock>;
use List::Util qw< any all reduce >;

my %o = (dict => '../../../data/dictionary.txt');
GetOptions(\%o, qw< dict=s test benchmark >)
    or die "Usage: $0 [--dict=path/to/dict.txt] [--test] [--benchmark]\n";

#
# Optional part! This one's for you, Colin. :-)
#
# Most DOS floppy bit errs abort boot.
# Best bet for a fix now is to beg for a copy of my floppy!
# Or, go for almost any beer or gin. Any buzz, not choosy.
#


# Challenge output requirement

our @words = read_lines($o{dict}); # "our" helps Benchmark. Use my normally.
say for sort { length $b <=> length $a } abcd_words(@words);


# Here are the abecedarian filters themselves

sub is_abcd_sort   { $_ eq join '', sort split // }

sub is_abcd_reduce { '~' ne reduce { $a gt $b ? '~' : $b } split // }

sub is_abcd_regex  { /^a*b*c*d*e*f*g*h*i*j*k*l*m*n*
                       o*p*q*r*s*t*u*v*w*x*y*z*$/x }

sub is_abcd_loop   {
    my $last;
    for my $ch (split //) {
        return if $last gt $ch;
        $last = $ch;
    }
    $_;
}

# Two different C versions, for fun

use Inline 'C' => <<'END'
/* This does the actual checking, used by the next two functions */
int __is_abcd(unsigned char *s) {
    unsigned char last = 0;
    for (unsigned char *p = s; *p; last = *p, p++ )
        if (last > *p)
            return 0;

    return 1;
}

/* Boolean, works on $_ */
int is_abcd_inline() {
    SV *var = get_sv("_", GV_ADD);
    unsigned char *s = SvPVutf8_nolen(var);

    return __is_abcd(s);
}

/* Process the entire list */
void abcd_words(SV *word, ...) {
    Inline_Stack_Vars;

    Inline_Stack_Reset;
    for (int i = 0; i < Inline_Stack_Items; i++) {
        if (__is_abcd(SvPV(Inline_Stack_Item(i), PL_na)))
            Inline_Stack_Push(Inline_Stack_Item(i));
    }
    Inline_Stack_Done;
}
END
;


#
# Tests
#

my %filters = map { $_ => "grep \&is_abcd_$_, \@words" } 
    qw< sort regex loop reduce inline >;

$filters{inlAll} = "abcd_words(\@words)";

if ($o{test}) {
    use Test::More;
    # Loop version will be our reference version, but it doesn't matter,
    # as any discrepancy will throw an error
    my $abcd= [ grep  &is_abcd_loop, @words ];

    is_deeply [ eval $filters{$_} ], $abcd, $_ for sort keys %filters;

    done_testing;
}

#
# Benchmarking
#

cmpthese(-5 => \%filters) if $o{benchmark};
