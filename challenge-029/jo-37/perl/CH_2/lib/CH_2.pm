package CH_2;

use 5.032001;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use CH_2 ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
    erf	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
);

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('CH_2', $VERSION);

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=encoding utf-8

=head1 NAME

CH_2 - Perl extension for erf

=head1 SYNOPSIS

  use CH_2 ':all';
  $erf = erf $x;

=head1 DESCRIPTION

This module demonstrates the call of a C library function from
perl.  The only function provided is C<erf>

=head2 EXPORT

This module exports C<erf> on request.

=head1 AUTHOR

Jörg Sommrey, E<lt>jo@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2023 by Jörg Sommrey

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.32.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
