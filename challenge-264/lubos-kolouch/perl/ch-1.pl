use strict;
use warnings;

sub greatest_english_letter {
    my ($str) = @_;
    my %seen;

    # Mark the occurrence of each letter in uppercase and lowercase
    foreach my $char (split //, $str) {
        if ($char =~ /[A-Z]/) {
            $seen{lc $char}{'upper'} = 1;
        } elsif ($char =~ /[a-z]/) {
            $seen{lc $char}{'lower'} = 1;
        }
    }

    # Identify the greatest letter that appears in both cases
    my $greatest_letter = '';
    foreach my $letter (keys %seen) {
        if ($seen{$letter}{'upper'} && $seen{$letter}{'lower'}) {
            $greatest_letter = $letter if $letter gt $greatest_letter;
        }
    }

    return uc $greatest_letter;
}

# Test the function
die "Error" unless greatest_english_letter('PeRlwEeKLy') eq 'L';
die "Error" unless greatest_english_letter('ChaLlenge') eq 'L';
die "Error" unless greatest_english_letter('The') eq '';
