#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

say 'The file content is ', (-T shift) ? 'ascii' : 'binary', '.';

