#!/usr/bin/env perl

use Modern::Perl;

$_ = shift // "";
say /^ [-+]?
       (?: \d+ \. \d* |
           \d* \. \d+ |
           \d+
       )
       (?: e [-+]? \d+ )?
    $/ix ? "true" : "false";
