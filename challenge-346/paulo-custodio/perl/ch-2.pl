#!/usr/bin/env perl

use Modern::Perl;

# List of operators to inject
my @operators = ('+', '-', '*');

@ARGV==2 or die "usage: $0 digits target\n";
my($digits, $target) = @ARGV;

my @all_expr = generate_expressions($digits);
my @result = grep { eval($_) == $target } @all_expr;
say "(", join(", ", sort @result), ")";


sub generate_expressions {
    my($string) = @_;
    my @results;

    # Internal helper for backtracking partitions
    my $backtrack;
    $backtrack = sub {
        my($remaining, $current_parts) = @_;

        # Base case: string fully partitioned
        if (length($remaining) == 0) {
            # For this specific partition, generate all operator combos
            push @results, combine_with_operators($current_parts);
            return;
        }

        for my $len (1 .. length($remaining)) {
            # skip parts with leading zeros
            my $next_part = substr($remaining, 0, $len);
            next if $next_part =~ /^0\d+/;

            # try with this substring and next part
            push @$current_parts, $next_part;
            $backtrack->(substr($remaining, $len), $current_parts);
            pop @$current_parts; # Backtrack
        }
    };

    $backtrack->($string, []);
    return @results;
}

# Helper to inject operators (+, -, *) between partition elements
sub combine_with_operators {
    my ($parts) = @_;
    return $parts->[0] if @$parts == 1; # No gaps if only one part

    my @expressions = ($parts->[0]);

    # For each subsequent part, multiply existing expressions by all 3 operators
    for my $i (1 .. $#$parts) {
        my @next_gen;
        for my $expr (@expressions) {
            for my $op (@operators) {
                push @next_gen, $expr . $op . $parts->[$i];
            }
        }
        @expressions = @next_gen;
    }

    return @expressions;
}
