#!/usr/bin/env perl
use strict;
use warnings;

sub format_phone_number{
  my ($phone) = @_;
  s/[- ]//g,
  s/(...)/$1-/g,
  s/-(.?)$/$1/,
  s/(^|-)(\d{2})(\d{2})$/$1$2-$3/ for $phone;
  $phone
}

printf "%s\n",format_phone_number('1-23-45-6');
printf "%s\n",format_phone_number('1234');
printf "%s\n",format_phone_number('12 345-6789');
printf "%s\n",format_phone_number('123 4567');
printf "%s\n",format_phone_number('123 456-78')

