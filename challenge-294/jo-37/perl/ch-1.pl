#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use if $::verbose, 'Data::Dump', 'pp';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [--] [I...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

I...
    list of integers

EOS


### Input and Output

say consecutive_sequence(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/11/08/ch-294.html#task-1

sub dbg {
    say $_[0], (pp($_[1])) x !!$_[1] if $verbose;
}

sub consecutive_sequence {
    dbg "got ", \@_;
    my @sequence;
    my %wanted;
    for my $i (@_) {
        dbg qq(processing "$i");
        if (exists $wanted{$i}) {
            next unless defined $wanted{$i};
            if (exists $wanted{$i}{hi} && !exists $wanted{$i}{lo}) {
                dbg "extending hi";
                $sequence[$wanted{$i}{hi}]{lo} = $i;
                $wanted{$i - 1}{hi} = $wanted{$i}{hi};
            } elsif (exists $wanted{$i}{lo} && !exists $wanted{$i}{hi}) {
                dbg "extending lo";
                $sequence[$wanted{$i}{lo}]{hi} = $i;
                $wanted{$i + 1}{lo} = $wanted{$i}{lo};
            } elsif (exists $wanted{$i}{lo} && exists $wanted{$i}{hi}) {
                dbg "joining hi and lo";
                my $hi = delete $sequence[$wanted{$i}{hi}];
                $sequence[$wanted{$i}{lo}]{hi} = $hi->{hi};
                $wanted{$hi->{hi} + 1}{lo} = $wanted{$i}{lo};
            }
        } else {
            dbg "new sequence";
            my %seq = (lo => $i, hi => $i);
            push @sequence, \%seq;
            $wanted{$i + 1}{lo} = $#sequence;
            $wanted{$i - 1}{hi} = $#sequence;
        }
        $wanted{$i} = undef;
        dbg "sequence: ", \@sequence;
        dbg "wanted: ", \%wanted;
    }
    my $max = {lo => 1, hi => 0};
    for my $seq (@sequence) {
        next unless defined $seq;
        $max = $seq if $seq->{hi} - $seq->{lo} > $max->{hi} - $max->{lo};
    }
    dbg "max sequence: ", $max;
    $max->{hi} > $max->{lo} ? $max->{hi} - $max->{lo} + 1 : -1;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is consecutive_sequence(10, 4, 20, 1, 3, 2), 4, 'example 1';
        is consecutive_sequence(0, 6, 1, 8, 5, 2, 4, 3, 0, 7), 9, 'example 2';
        is consecutive_sequence(10, 30, 20), -1, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is consecutive_sequence(1, 4, 7, 2), 2, 'consecutive pair';
    }

    done_testing;
    exit;
}
