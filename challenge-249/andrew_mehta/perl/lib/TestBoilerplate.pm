package TestBoilerplate;

use     CodeBoilerplate;
use     Import::Into;
use     Test::Output;
use     Test2::V0;
use     Test2::Tools::Compare;
use     Test2::Tools::Exception;

our $VERSION                        =   'v2.0.0';

sub import {

    # Initial Variables:
    my  $calling_module_level_depth =   1;
    my  @compare_imports            =   qw{
                                            is like isnt unlike
                                            match mismatch validator
                                            hash array bag object meta number float rounded within string subset bool
                                            in_set not_in_set check_set
                                            item field call call_list call_hash prop check all_items all_keys all_vals all_values
                                            etc end filter_items
                                            T F D DF E DNE FDNE U L
                                            event fail_events
                                            exact_ref
                                        };

    # Processing / Declaring what to import:
    CodeBoilerplate         ->import::into  ($calling_module_level_depth);
    Test::Output            ->import::into  ($calling_module_level_depth);
    Test2::V0               ->import::into  ($calling_module_level_depth);
    Test2::Tools::Compare   ->import::into  ($calling_module_level_depth, @compare_imports);
    Test2::Tools::Exception ->import::into  ($calling_module_level_depth);

}

# Protect subclasses using AUTOLOAD
sub DESTROY { }

1;

__END__
