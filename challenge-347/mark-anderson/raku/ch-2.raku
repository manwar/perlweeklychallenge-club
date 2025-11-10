#!/usr/bin/env raku
use Test;

is format-phone-number('1-23-45-6'),   '123-456';
is format-phone-number('1234'),        '12-34';
is format-phone-number('12 345-6789'), '123-456-789';
is format-phone-number('123 4567'),    '123-45-67';
is format-phone-number('123 456-78'),  '123-456-78';

sub format-phone-number($phone is copy)
{
    $phone .= subst(/<space> | '-'/, :g);

    .join('-') given do given $phone.chars mod 3
    {
        when 0 { 
                   m:g/.../ given $phone 
               }

        when 1 { 
                   flat .substr(0, *-4) ~~ m:g/.../, 
                        .substr(   *-4) ~~ m:g/../   given $phone
               }

        when 2 {
                   flat .substr(0, *-2) ~~ m:g/.../,
                        .substr(   *-2)              given $phone
               }
    }     
}
