use 5.036;
use Cpanel::JSON::XS;
use JSON::Schema::Modern;
use List::Util ();

sub nearest_valid_point($x, $y, $points) {
    my $nearest_index  = -1;
    my $distance;
    for my $i (0..$#$points) {
        my $this_distance;
        if ($points->[$i][0] == $x) {
            $this_distance = $y - $points->[$i][1];
        }
        elsif ($points->[$i][1] == $y) {
            $this_distance = $x - $points->[$i][0];
        }
        else {
            next;
        }
        $this_distance = -$this_distance if $this_distance < 0;
        if ($nearest_index < 0 or $this_distance < $distance) {
            $distance = $this_distance;
            $nearest_index = $i;
        }
    }
    return $nearest_index;
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
                "items": {
                    "type": "array",
                    "prefixItems": [{"type": "integer"},{"type": "integer"}],
                    "minItems": 2,
                    "items": false
                }
            }
        },
        "required": ["x","y","points"]
    }');

    for my $input_string (@ARGV) {
        my $input_object = eval { $json->decode($input_string) };
        if (! $input_object || ! $validator->evaluate($input_object, $schema)->valid) {
            say "Invalid input: ", $input_string;
            next;
        }

        my $result = nearest_valid_point(@$input_object{qw/x y points/});
        printf "%-30s -> %s\n", $input_string, $result;
    }

    return;
}

main() unless caller;
