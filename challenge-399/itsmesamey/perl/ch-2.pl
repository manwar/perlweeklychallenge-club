#!/usr/bin/env perl
use strict;
use warnings;
use Encode qw(decode FB_CROAK);

sub longest_absolute_path {
    my ($filesystem) = @_;
    die "Expected a filesystem string\n"
        if !defined($filesystem) || ref($filesystem);

    my @lines = split /\n/, $filesystem, -1;
    pop @lines if @lines && $lines[-1] eq '';
    my @entries;
    my $previous_depth = -1;
    for my $line (@lines) {
        $line =~ s/\r\z//;
        my ($tabs, $name) = $line =~ /\A(\t*)(.*)\z/s;
        my $depth = length $tabs;
        die "Expected nonempty names and consecutive nesting depths\n"
            if $name eq '' || $depth > $previous_depth + 1;
        push @entries, [$depth, $name];
        $previous_depth = $depth;
    }

    my @prefix_lengths;
    my $best = 0;
    for my $index (0 .. $#entries) {
        my ($depth, $name) = @{$entries[$index]};
        my $length = length($name)
            + ($depth ? $prefix_lengths[$depth - 1] + 1 : 0);
        $prefix_lengths[$depth] = $length;
        $#prefix_lengths = $depth;
        # Children make an entry a directory, even when its name has a dot.
        my $has_children = $index < $#entries
            && $entries[$index + 1][0] > $depth;
        if (!$has_children && index($name, '.') >= 0 && $length > $best) {
            $best = $length;
        }
    }
    return $best;
}

sub longest_absolute_path_cli {
    if (@_ == 1 && $_[0] eq '--help') {
        print "Usage: perl ch-2.pl [FILESYSTEM]\n";
        return 0;
    }
    if (@_ > 1) {
        print STDERR "Usage: perl ch-2.pl [FILESYSTEM]\n";
        return 2;
    }
    my ($argument) = @_;
    my $answer = eval {
        my $text;
        if (defined $argument) {
            $text = decode('UTF-8', $argument, FB_CROAK);
        }
        else {
            binmode STDIN, ':raw' or die "Cannot read stdin\n";
            local $/;
            $text = <STDIN>;
            $text = '' if !defined $text;
            $text = decode('UTF-8', $text, FB_CROAK);
        }
        longest_absolute_path($text);
    };
    if ($@) {
        print STDERR "Error: $@";
        return 2;
    }
    print "$answer\n";
    return 0;
}

exit longest_absolute_path_cli(@ARGV) unless caller;
1;

__END__

=head1 NAME

ch-2.pl - Longest Absolute Path for Weekly Challenge 399

=head1 DESCRIPTION

Track path lengths by tab depth. A dotted leaf is a file; an entry with children
is a directory. Slash separators count toward the path length. Read UTF-8 from
one argument or stdin and count Unicode code points. Empty input returns zero;
empty names and depth jumps are rejected. A final newline and CRLF are accepted.

=cut
