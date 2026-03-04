#!/usr/bin/env perl

use Modern::Perl;

say steps_to_strong(shift // "");

sub steps_to_strong {
    my($password) = @_;

    my $steps = 0;
    while (!is_strong($password)) {
        my $new_ch = next_char($password);

        if ($password =~ /(.)\1\1+/) {
            my $ch = $1;
            $password =~ s/$ch{3}/$ch$ch$new_ch$ch/;
        }
        else {
            $password .= $new_ch;
        }
        $steps++;
    }
    return $steps;
}

sub is_strong {
    local($_) = @_;
    return length($_)>=6 && /[a-z]/ && /[A-Z]/ && /[0-9]/ && !/(.)\1\1+/;
}

sub next_char {
    my($password) = @_;

    my $avail_chars = "";
    if ($password !~ /[0-9]/) {
        $avail_chars .= join "", '0'..'9';
    }
    if ($password !~ /[A-Z]/) {
        $avail_chars .= join "", 'A'..'Z';
    }
    if ($password !~ /[a-z]/) {
        $avail_chars .= join "", 'a'..'z';
    }
    $avail_chars .= join "", '0'..'9', 'A'..'Z', 'a'..'z';

    for my $ch (split //, $password) {
        $avail_chars =~ s/$ch//g;
    }

    return substr($avail_chars, 0, 1);
}
