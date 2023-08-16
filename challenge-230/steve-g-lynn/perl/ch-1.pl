#!/usr/bin/env -S perl -wl

&print_arry( &separate_digits(1,34,5,6) );
&print_arry( &separate_digits(1,24,51,60) );

sub separate_digits {
    split //, join '', @_;
}

sub print_arry {
    print join ',', @_;
}


