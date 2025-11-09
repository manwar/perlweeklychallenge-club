use 5.040;

sub longest_balanced_parentheses($string) {

    my $longest_length = 0;
    my $nested_depth = 0;
    my @start_index = 0;

    for my $index (0..length($string) - 1) {
        # opening parenthesis
        if (substr($string, $index, 1) eq '(') {
            ++$nested_depth;
            # a new potentially balanced string starts here, unless we just had a close paren for this same depth
            if (@start_index == $nested_depth) {
                push @start_index, $index;
            }
        }
        # closing parenthesis and there's something to close
        elsif ($nested_depth) {
            my $length = $index - $start_index[$nested_depth] + 1;
            if ($length > $longest_length) {
                $longest_length = $length;
            }

            # starting indexes deeper than this just closed depth are no longer relevant
            splice @start_index, $nested_depth+1;

            --$nested_depth;
        }
        # bad closing parenthesis; nothing before this is relevant anymore
        else {
            @start_index = $index + 1;
            $nested_depth = 0;
        }
    }

    return $longest_length;
}

sub main() {
    require Run::WeeklyChallenge;

    my $run_solution = sub ($inputs) {
        longest_balanced_parentheses($inputs);
    };
    my $inputs_example = '"()()"';
    my $inputs_schema_json = '{
        "type": "string"
    }';
    Run::WeeklyChallenge::run_weekly_challenge($run_solution, $inputs_example, $inputs_schema_json);
}

main() unless caller;
