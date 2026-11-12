#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use JSON ();
use File::Basename ();
use constant EXMP => File::Basename::dirname(__FILE__) . 
    '/../../examples/json/ch-2.json';
use experimental 'signatures';

use List::Util qw(max sum);


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - longest path

    usage: $0 [-examples] [-tests] [FS]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    FS
        file system structure in string format.
        Literal character combinations '\\n' and '\\t'
        in the string will be converted to linefeed and
        tab characters.

    EOS
}


### Input and Output

say longest_abs_path($ARGV[0] =~ s/\\n/\n/gr =~ s/\\t/\t/gr);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/13/ch-399.html#task-2

sub scan_fs ($fs) {
    use autodie;
    my $root = {name => '', parent => undef, children => []};
    my $lvl = 0;
    my $current = $root;
    open my $fsh, '<', \$fs;
    while (<$fsh>) {
        my ($head, $name) = /^(\t*)(.*)/;
        my $new_lvl = length $head;
        if ($new_lvl > $lvl) {
            $current = $current->{children}[-1];
            $lvl = $new_lvl;
        } elsif ($new_lvl < $lvl) {
            while ($new_lvl < $lvl) {
                $current = $current->{parent};
                $lvl--;
            }
        }
        my $new = {name => $name, parent => $current, children => []};
        push $current->{children}->@*, $new;
    }
    close $fsh;
    $root;
}

sub leaf_paths ($root) {
    my @files;
    for my $child ($root->{children}->@*) {
        push @files, [$root->{name}, @$_] for __SUB__->($child)->@*;
    }
    @files ? [@files] : [[$root->{name}]];
}

sub longest_abs_path ($fs) {
    my $root = scan_fs ($fs);
    my $leaves = leaf_paths($root);

    max(map @$_ - 2 + sum(map length, @$_),
        grep $_->[-1] =~ /\./, $leaves->@*) // 0;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    use Data::Dump 'pp';
    return unless $examples || $tests;

    state sub fa {
        [join ', ', map(pp($_), @_)];
    }

    state sub run_example ($args, $expected, $name) {
        my $result = [longest_abs_path(@$args)];

        is $result, $expected,
            "$name: (@{fa(@$args)}) -> @{fa(@$expected)}";
    }
    return unless $examples || $tests;

    plan 2;
    my $exmp = do {
        use autodie;
        local $/;
        open my $xfh, '<', EXMP;
        my $ex = JSON->new->utf8->boolean_values(0, 1)->decode(<$xfh>);
        close $xfh;
        $ex; 
    };

    $examples ? subtest_streamed($exmp->{challenge}{name} => sub {
        plan scalar $exmp->{examples}->@*;
        run_example $_->{in}, $_->{out}, $_->{name}
            for $exmp->{examples}->@*;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        is longest_abs_path("dir\n\tsubdir1\n\t\tfile1.ext\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.ext"), 32, 'from description';
    }) : pass 'skip tests';

    exit;
}
