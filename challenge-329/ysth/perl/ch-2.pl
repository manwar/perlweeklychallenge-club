use 5.036;

my @inputs = @ARGV;

# if given command line arguments, do those
if (@inputs) {
    for my $string (@inputs) {
        printf "%-30s -> %s\n", $string, longest_nice_substring($string);
    }
}
# otherwise, run an endless test of random values, comparing to simple version (stopping if an unexpected difference was found)
else {
    my $checked;
    STDOUT->autoflush();
    {
        my @ascii_letters = ('A'..'Z', 'a'..'z');
        my $string = join '', map $ascii_letters[rand @ascii_letters], 1..rand 200;
        printf "$checked\r" unless ++$checked % 1000;
        redo if simple_longest_nice_substring($string) eq longest_nice_substring($string);
        printf "string:  %s\nsimple:  %s\ncomplex: %s\n", $string, simple_longest_nice_substring($string), longest_nice_substring($string);
    }
}

sub simple_longest_nice_substring($string) {
    my $longest_nice_substring = '';
    for my $starting_index (0..length($string)-1) {
        my %nice;
        my %not_yet_nice;
        for my $ending_index ($starting_index..(length($string)-1)) {
            my $c = substr $string, $ending_index, 1;
            if (! $nice{$c} && ! $not_yet_nice{$c}) {
                if ($not_yet_nice{$c ^. ' '}) {
                    delete $not_yet_nice{$c ^. ' '};
                    $nice{$c} = $nice{$c ^. ' '} = 1;
                }
                else {
                    $not_yet_nice{$c} = 1;
                }
            }
            if (! %not_yet_nice && $ending_index - $starting_index + 1 > length $longest_nice_substring) {
                $longest_nice_substring = substr $string, $starting_index, $ending_index - $starting_index + 1;
            }
        }
    }

    return $longest_nice_substring;
}

sub longest_nice_substring($string) {

    # longest nice substring found so far
    my $longest_nice_substring = '';

    # characters that we know can't form part of a not yet found nice substring
    my %never_nice = map(($_ => 1), split //, $string);
    delete @never_nice{map $_ ^. ' ', keys %never_nice};

    # loop over starting indexes while it is possible to find a longer nice substring
    my $next_starting_index;
    for (my $starting_index = 0; length($string) - $starting_index > length($longest_nice_substring); $starting_index = $next_starting_index) {
        my $c = substr $string, $starting_index, 1;
        ++$next_starting_index;

        # can we rule out any substring starting here?
        next if $never_nice{$c};
        # shortest substring that may be nice will end with the opposite character
        my $ending_index = index($string, $c ^. ' ', $next_starting_index) + 1;
        if ($ending_index == 0) {
            $never_nice{$c} = 1;
            next;
        }

        # what we know so far about substrings starting at this starting index
        my $substring_prefix = substr $string, $starting_index, $ending_index - $starting_index;
        my %nice = my %not_yet_nice = map(($_ => 1), split //, $substring_prefix);
        delete @not_yet_nice{map $_ ^. ' ', keys %not_yet_nice};
        delete @nice{keys %not_yet_nice};

        # found a nice substring?
        if (! %not_yet_nice) {
            if (length $substring_prefix > length $longest_nice_substring) {
                $longest_nice_substring = $substring_prefix;
            }
            # any nice strings starting in the middle of or just after this nice
            # string will also be nice if started at the beginning of it, so
            # this iteration of the outer loop will find them and the next
            # iteration can be farther on
            $next_starting_index = $ending_index + 1;
        }

        # look for longer nice substrings starting at this starting index
        for my $ending_index ($ending_index..(length($string)-1)) {
            $c = substr $string, $ending_index, 1;

            # character we know there's no match for later?
            last if $never_nice{$c};

            # character not yet seen in this substring?
            if (! $nice{$c} && ! $not_yet_nice{$c}) {
                # completes an upper/lower pair?
                my $c_opposite = $c ^. ' ';
                if ($not_yet_nice{$c_opposite}) {
                    delete $not_yet_nice{$c_opposite};
                    $nice{$c} = $nice{$c ^. ' '} = 1;
                }
                else {
                    $not_yet_nice{$c} = 1;
                }
            }
            if (! %not_yet_nice) {
                if ($ending_index - $starting_index >= length $longest_nice_substring) {
                    $longest_nice_substring = substr $string, $starting_index, $ending_index - $starting_index + 1;
                }
                # any nice strings starting in the middle of or just after this
                # nice string will also be nice if started at the beginning of
                # it, so this iteration of the outer loop will find them and the
                # next iteration can be farther on
                $next_starting_index = $ending_index + 2;
            }
        }
    }

    return $longest_nice_substring
}

