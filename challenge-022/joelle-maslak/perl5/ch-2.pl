#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Gets the name of the most recent newsletter

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;
use bignum;
use Getopt::Long;

sub main() {
    my $bits = 12;
    my ( $infile, $outfile );
    GetOptions(
        "infile=s"  => \$infile,
        "outfile=s" => \$outfile,
        "bits=i"    => \$bits,
    );
    if ( @ARGV == 0 ) { die("Must provide command (compress/decompress)") }
    if ( @ARGV > 1 )  { die("Invalid parameter") }

    my $command = shift(@ARGV);
    die "Must provide --infile option"  unless defined($infile);
    die "Must provide --outfile option" unless defined($outfile);

    die "--infile not readable" unless -r $infile;
    die "--outfile exists" if -e $outfile;

    die "--bits must be >= 8" unless $bits >= 8;

    if ( $command eq 'compress' ) {
        compress( $infile, $outfile, $bits );
    } elsif ( $command eq 'decompress' ) {
        decompress( $infile, $outfile, $bits );
    } else {
        die "Unknown command: $command";
    }
}

sub compress ( $infile, $outfile, $bits ) {
    my $dict = Dictionary->new( bits => $bits );

    open my $in, '<:raw', $infile;
    my $out = BitwiseWrite->new( filename => $outfile, bits => $bits );

    my $buf = '';
    my $c;
    while (read $in, $c, 1) {
        $buf .= $c;
        next if $dict->lookup($buf);

        # Okay, we don't have the string - how much do we write out?
        $dict->store($buf);    # First we store this for future use.

        # Now we write up what we can lookup
        $buf = substr( $buf, 0, length($buf) - 1 );
        $out->write( $dict->lookup($buf) );

        # Now we reset the buffer
        $buf = $c;
    }
    close $in;

    # Flush pending buffered characters (if any)
    $out->write( $dict->lookup($buf) ) unless $buf eq '';

    $out->close;
}

sub decompress ( $infile, $outfile, $bits ) {
    my $dict = Dictionary->new( bits => $bits );
    
    my $in = BitwiseRead->new(filename => $infile, bits => $bits);
    open my $out, '>:raw', $outfile;

    my $prevbuf = '';
    while (defined(my $value = $in->read())) {
        my $buf = $dict->index($value);
        if (!defined($buf)) {
            $buf = $prevbuf;
            $buf .= substr($buf, 0, 1);
            $dict->store($buf);
        } else {
            if ($prevbuf ne '') {
                $prevbuf .= substr($buf, 0, 1);
                $dict->store($prevbuf);
            }
        }
        print $out $buf;
        $prevbuf = $buf;
    }
}

package Dictionary {
    use Moose;
    use feature 'signatures';
    no warnings 'experimental::signatures';

    has dict => (
        is       => 'ro',
        isa      => 'HashRef',
        default  => sub { return {} },
        init_arg => undef,
    );

    has idx => (
        is       => 'ro',
        isa      => 'HashRef[Str]',
        default  => sub { return {} },
        init_arg => undef,
    );

    has next => (
        is       => 'rw',
        default  => '0',
        init_arg => undef,
    );

    has bits => (
        is      => 'ro',
        default => sub { 12 },
    );

    sub BUILD ( $self, $args ) {
        for my $i ( 0 .. 255 ) {
            $self->store( chr($i) );
        }
    }

    sub lookup ( $self, $val ) {
        return $self->dict->{$val} if exists $self->dict->{$val};
        return;
    }

    sub index ( $self, $index ) {
        return unless exists $self->idx->{$index};
        return $self->idx->{$index};
    }

    sub store ( $self, $val ) {
        return $self->lookup($val) if defined $self->lookup($val);
        return if $self->next >= 2**( $self->bits );

        $self->dict->{$val} = $self->next;
        $self->idx->{ $self->next } = $val;

        $self->next( $self->next + 1 );

        return $self->dict->{$val};
    }

    __PACKAGE__->meta->make_immutable;
}

package BitwiseWrite {
    use Moose;
    use feature 'signatures';
    no warnings 'experimental::signatures';

    has filename => (
        is       => 'ro',
        isa      => 'Str',
        required => 1,
    );

    has bits => (
        is       => 'ro',
        required => 1,
    );

    has fh => (
        is       => 'rw',
        init_arg => undef,
    );

    has pending => (
        is       => 'rw',
        default  => sub { 0 },
        init_arg => undef,
    );

    has pending_bits => (
        is       => 'rw',
        default  => sub { 0 },
        init_arg => undef,
    );

    sub BUILD ( $self, $args ) {
        open my $fh, '>:raw', $self->filename;
        $self->fh($fh);
    }

    sub write ( $self, $val ) {
        my $bits = $self->bits;

        $val  += $self->pending << $bits;
        $bits += $self->pending_bits;

        while ( $bits >= 8 ) {
            my $tmp = ( $val >> ( $bits - 8 ) ) % 256;
            my $fh  = $self->fh;
            print $fh chr($tmp);
            $bits -= 8;
        }

        $self->pending( ( ( $val << ( 8 - $bits ) ) % 256 ) >> ( 8 - $bits ) );
        $self->pending_bits($bits);
    }

    sub close($self) {
        if ( $self->pending_bits > 0 ) {
            my $fh = $self->fh;
            print $fh chr( $self->pending << ( 8 - $self->pending_bits ) );
        }
        close $self->fh;
    }

    __PACKAGE__->meta->make_immutable;
}

package BitwiseRead {
    use Moose;
    use feature 'signatures';
    no warnings 'experimental::signatures';

    has filename => (
        is       => 'ro',
        isa      => 'Str',
        required => 1,
    );

    has bits => (
        is       => 'ro',
        required => 1,
    );

    has fh => (
        is       => 'rw',
        init_arg => undef,
    );

    has pending => (
        is       => 'rw',
        default  => sub { 0 },
        init_arg => undef,
    );

    has pending_bits => (
        is       => 'rw',
        default  => sub { 0 },
        init_arg => undef,
    );

    sub BUILD($self, $args) {
        open my $fh, '<:raw', $self->filename;
        $self->fh($fh);
    }

    sub read($self) {
        my $val = $self->pending;
        my $bits = $self->pending_bits;

        while ($bits < $self->bits) {
            my $c;
            return unless read $self->fh, $c, 1;

            $val = $val << 8;
            $val += ord($c);
            $bits += 8;
        }

        $self->pending_bits( $bits - $self->bits );
        my $out = $val >> $self->pending_bits;
        $self->pending($val - ($out << $self->pending_bits) );

        return $out;
    }

    sub close($self) {
        close $self->fh;
    }

    __PACKAGE__->meta->make_immutable;
}

main();

