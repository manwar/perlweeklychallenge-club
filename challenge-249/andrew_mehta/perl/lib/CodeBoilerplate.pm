package CodeBoilerplate;

use     strict;
use     warnings;
use     utf8;

my      $feature_bundle;
my      $version_number_to_use;

BEGIN {
        $version_number_to_use      =   '5.38';
        $feature_bundle             =   ':'.$version_number_to_use;
};

use     feature "$feature_bundle";

use     Import::Into;
use     English;

our $VERSION                        =   'v2.0.0';

sub import {

    # Initial Variables:
    my  $calling_module_level_depth =   1;

    # Processing / Declaring what to import:
    $ARG        ->import        for qw(strict warnings utf8);
    feature     ->import        ($feature_bundle);
    English     ->import::into  ($calling_module_level_depth);

    #UTF-8 the default on standard input and output:
    binmode     STDIN,          ":encoding(UTF-8)";
    binmode     STDOUT,         ":encoding(UTF-8)";
    binmode     STDERR,         ":encoding(UTF-8)";

}

# Protect subclasses using AUTOLOAD
sub DESTROY { }

1;

__END__