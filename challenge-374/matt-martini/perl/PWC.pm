package PWC;

use Dev::Util::Syntax;
use Exporter            qw(import);
use File::JSON::Slurper qw(read_json);
use JSON::PP;
use Test2::V0;
use Data::Printer;

our $VERSION = version->declare("v0.5.12");

our @EXPORT = qw(
    get_json_data
    print_inputs
    print_outputs
);

our @EXPORT_OK = qw(
    get_json_data
    print_inputs
    print_outputs
);

our %EXPORT_TAGS = ( all => \@EXPORT_OK );

sub get_json_data {
    my $json_ref = read_json( $0 =~ s/pl$/json/r )
        or die "ERROR: could not read test data from json file\n";

    my $challenge_ref  = $json_ref->{ challenge };
    my $input_vars_ref = $json_ref->{ input_vars };
    my $examples_ref   = $json_ref->{ examples };

    # Convert any expected output strings "true" and "false"
    # as well as JSON Boolean constants true and false
    # into Test2::V0::Compare T and F conditions.
    for ( @{ $examples_ref } ) {
        for ( @{ $_->{ out } } ) {
            if ( /^(?:(true)|(false))$/i || JSON::PP::is_bool($_) ) {
                $_ = $1 ? T : $2 ? F : $_ ? T : F;
            }
        }
    }

    printf qq{\nChallenge: %s Task %s: %s\n},
        $challenge_ref->{ week },
        $challenge_ref->{ task },
        $challenge_ref->{ name };

    return $json_ref;
}

sub print_inputs {
    my $input_vars_ref = shift;
    my @data           = @_;
    my @exp_data       = $data[0]->@*;

    print qq{\nInput:};

    if ( substr( $input_vars_ref->[0], 0, 1 ) eq q{@} ) {
        printf qq{ %s = ("%s")\n}, $input_vars_ref->[0], join '", "' => @exp_data;
        return;
    }
    if ( @exp_data > 1 ) {
        for my $inp ( 0 .. $#exp_data - 1 ) {
            printf qq{ %s = "%s",}, $input_vars_ref->[$inp], $exp_data[$inp];
        }
    }
    printf qq{ %s = "%s"\n}, $input_vars_ref->[-1], $exp_data[-1];

    return;
}

sub print_outputs {
    my ($result) = @_;
    print q{Output: } . np( $result, multiline => 0 ) . qq{\n};
    return;
}

1;
