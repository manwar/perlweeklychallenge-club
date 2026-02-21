#!/usr/bin/env perl

use Modern::Perl;

say deleted_cols(@ARGV);

sub deleted_cols {
    my(@words) = @_;
    my @cols = transpose(@words);
    my $num_delete = scalar grep {sort_word($_) ne $_} @cols;
    return $num_delete;
}

sub transpose {
    my(@words) = @_;
    my @cols;
    for my $col (0 .. length($words[0]) - 1) {
        for my $row (0 .. $#words) {
            $cols[$col] .= substr($words[$row], $col, 1);
        }
    }
    return @cols;
}

sub sort_word {
    my($word) = @_;
    return join '', sort split //, $word;
}
