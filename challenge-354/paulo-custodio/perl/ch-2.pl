#!/usr/bin/env perl

use Modern::Perl;

sub parse_input {
    my($k, @m);

    chomp(my @rows = <>);
    while (@rows) {
        if ($rows[0] =~ s/^\s*matrix\s*=\s*//) {
            while (@rows && $rows[0] =~ /^\s*\d+/) {
                my @row = map {0+$_} split(/,/, $rows[0]);
                push @m, \@row;
                shift @rows;
            }
        }
        elsif ($rows[0] =~ /^\s*k\s*=\s*(\d+)\s*$/) {
            $k = 0+$1;
            shift @rows;
        }
        else {
            die "invalid input: @rows\n";
        }
    }

    return($k, @m);
}

sub print_output {
    my(@m) = @_;
    for (@m) {
        my @row = @$_;
        say join(", ", @row), ",";
    }
}

sub shift_grid {
    my($k, @m) = @_;

    for my $n (1 .. $k) {
        my $ins = $m[-1][-1];   # last item
        for my $row (@m) {
            unshift @$row, $ins;
            $ins = pop @$row;
        }
    }
    return @m;
}

my($k, @m) = parse_input();
@m = shift_grid($k, @m);
print_output(@m);
