#!/usr/bin/env raku
use Test;

is no-connection((<B C>, <D B>, <C A>)), 'A';
is no-connection((<A Z>,)),              'Z';

sub no-connection($routes)
{
    $routes>>[1] (-) $routes>>[0]
}
