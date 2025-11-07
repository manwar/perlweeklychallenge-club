use 5.040;
use Cpanel::JSON::XS;
use JSON::Schema::Modern;
use List::Util ();

sub magic_expression($string, $target) {

    my @solutions;

    my $glob_pattern = join '{,+,\*,-}', split //, $string;
    while (my $expression = glob $glob_pattern) {
        # from the challenge examples, we won't allow extra leading 0's in numbers in the expression
        next if $expression =~ /\b0[0-9]/;

        push @solutions, $expression if eval $expression == $target;
    }

    return @solutions;
}

sub main() {
    my $input_example = '{"string":"123","target":6}';

    my $input_schema = '{
        "type": "object",
        "properties": {
            "string": {
                "type": "string",
                "pattern": "^[0-9]+$"
            },
            "target": {"type": "integer"}
        },
        "required": ["string","target"],
        "additionalProperties": false
    }';

    my $run_solution = sub ($inputs) {
        # format results like: ("2*3+2", "2+3*2")
        sprintf '(%s)', join ', ', map qq!"$_"!,
            magic_expression($inputs->{'string'}, $inputs->{'target'});
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
