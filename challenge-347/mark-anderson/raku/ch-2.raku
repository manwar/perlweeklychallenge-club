#!/usr/bin/env raku
use Test;

is format-phone-number('1-23-45-6'),   '123-456';
is format-phone-number('1234'),        '12-34';
is format-phone-number('12 345-6789'), '123-456-789';
is format-phone-number('123 4567'),    '123-45-67';
is format-phone-number('123 456-78'),  '123-456-78';

sub format-phone-number($str is copy)
{
    $str .= subst(/<space> | '-'/, :g);

    do given $str.chars % 3
    {
        when 0 { 
                   .join('-') given $str ~~ m:g/.../ 
               }

        when 1 { 
                   .join('-') given flat 
                   $str.substr(0, *-4) ~~ m:g/.../, 
                   $str.substr(   *-4) ~~ m:g/../
               }

        when 2 {
                   .join('-') given flat 
                   $str.substr(0, *-2) ~~ m:g/.../,
                   $str.substr(   *-2)
               }
    }     
}
