use 5.040;
use Cpanel::JSON::XS;
use JSON::Schema::Modern;
use List::Util ();

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
    my $input_example = '"()()"';

    my $input_schema = '{
        "type": "string"
    }';

    my $run_solution = sub ($inputs) {
        longest_balanced_parentheses($inputs);
    };

    my $json = Cpanel::JSON::XS->new->allow_nonref;
    my $validator = JSON::Schema::Modern->new( 'specification_version' => 'draft2020-12', 'output_format' => 'flag' );
    my $schema = $json->decode($input_schema);

    my $errors;

    for my $inputs_json (@ARGV) {
        say "Input: $inputs_json";

        try {
            my $inputs = $json->decode($inputs_json);
            if (! $validator->evaluate($inputs, $schema)->valid) {
                $errors = true;
                say "Error: invalid input";
                next;
            }
            else {
                try {
                    my $result = $run_solution->($inputs);
                    say "Output: $result";
                }
                catch ($e) {
                    chomp $e;
                    say "Error: $e";
                }
            }
        }
        catch ($e) {
            $errors = true;
            chomp $e;
            say "Error: invalid json input: $e";
            next;
        }
    }

    if ($errors) {
        say "Expected arguments like '$input_example'";
    }

    return;
}

main() unless caller;
