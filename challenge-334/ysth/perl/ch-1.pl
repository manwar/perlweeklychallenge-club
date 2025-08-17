use 5.036;
use Cpanel::JSON::XS;
use JSON::Schema::Modern;
use List::Util ();

sub range_sum($ints, $x, $y) {
    die "index out of range" if $x < 0 || $y < $x || $y > $#$ints;

    return List::Util::sum($ints->@[$x..$y])
}

sub main() {
    my $json = Cpanel::JSON::XS->new;
    my $validator = JSON::Schema::Modern->new(
        'specification_version' => 'draft2020-12',
        'output_format' => 'flag',
    );
    my $schema = $json->decode('{
        "type": "object",
        "properties": {
            "x": {"type": "integer"},
            "y": {"type": "integer"},
            "points": {
                "type": "array",
                "items": { "type": "integer" }
            }
        },
        "required": ["ints","x","y"]
    }');

    for my $input_string (@ARGV) {
        my $input_object = eval { $json->decode($input_string) };
        if (! $input_object || ! $validator->evaluate($input_object, $schema)->valid) {
            say "Invalid input: ", $input_string;
            next;
        }

        my $result = range_sum(@$input_object{qw/ints x y/});
        printf "%-30s -> %s\n", $input_string, $result;
    }

    return;
}

main() unless caller;
