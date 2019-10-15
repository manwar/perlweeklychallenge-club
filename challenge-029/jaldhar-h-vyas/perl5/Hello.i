%module Hello

%{
    #include "hello.h"
%}

void hello();

%perlcode %{
    @EXPORT = qw( hello );
%}