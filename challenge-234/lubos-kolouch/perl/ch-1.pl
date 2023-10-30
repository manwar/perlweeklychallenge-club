use strict;
use warnings;
use List::Util qw(all);

sub common_characters {
    my @words = @_;
    
    # Count characters for each word
    my @char_counts;
    for my $word (@words) {
        my %count;
        $count{$_}++ for split //, $word;
        push @char_counts, \%count;
    }

    # Find common characters
    my @common_chars;
    for my $char (keys %{$char_counts[0]}) {
        if (all { exists $_->{$char} } @char_counts) {
            push @common_chars, $char;
        }
    }

    return @common_chars;
}

# Testing the Perl solution
print join(", ", common_characters("java", "javascript", "julia")), "\n";  # Output: j, a
print join(", ", common_characters("bella", "label", "roller")), "\n";    # Output: e, l
print join(", ", common_characters("cool", "lock", "cook")), "\n";        # Output: c, o

