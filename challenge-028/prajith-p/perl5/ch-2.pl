#!/usr/bin/perl

use feature qw<say>;
use strict;
use Tie::IxHash;

#inspired by https://github.com/cauefcr/py-ascii-digital-clock

our $buf       = Clock::Buffer->new();
our $big_chars = {};

package main {

    sub get_big_chars {
        local $/;
        my $content = <DATA>;
        my @dig_in  = split( '\n', $content );
        my $curr    = 0;
        my $j       = 0;

        foreach my $i (@dig_in) {
            if ( substr( $i, 0, 1 ) eq '-' ) {
                $curr               = substr $i, 1;
                $j                  = 0;
                $big_chars->{$curr} = Clock::LargeNumber->new($curr);
            }
            else {
                if ( $j != 0 ) { $big_chars->{$curr}->add_str( $j - 1, $i ) }
            }
            $j += 1;
        }
    }

    sub new_separator {
        for my $i ( keys %{ $buf->lines } ) {
            my $line = $buf->lines->{$i} . " ";
            $buf->set_line( $i, $line );
        }
    }

    sub load_to_buf {
        my $time_str = shift;
        my @c = split( "", $time_str );

        for my $char (@c) {
            $big_chars->{$char}->add_to_buffer;
            new_separator();
        }
    }

    sub get_time_string {
        my ( $S, $M, $H ) = localtime(time);
        return $H . ":" . "$M" . ":" . "$S";
    }

    &get_big_chars();
    while (1) {
        sleep(1);
        system("clear");
        my $now = get_time_string();
        load_to_buf($now);
        $buf->print_lines();
        $buf->clean();
    }

}

package Clock::Buffer {

    sub new {
        my $class = shift;

        my %lines;
        my $t = tie %lines, 'Tie::IxHash';
        %lines = (
            0 => "",
            1 => "",
            2 => "",
            3 => "",
            4 => "",
            5 => "",
            6 => "",
            7 => "",
            8 => ""
        );

        my $self = { lines => \%lines };
        return bless $self, $class;
    }

    sub print_lines {
        my $self = shift;
        for my $line ( keys %{ $self->{'lines'} } ) {
            say $self->{'lines'}->{$line};
        }
    }

    sub clean {
        my $self = shift;
        for my $line ( keys %{ $self->{'lines'} } ) {
            $self->{'lines'}->{$line} = "";
        }
    }

    sub set_line {
        my ( $self, $k, $v ) = @_;
        $self->{'lines'}->{$k} = $v;
    }

    sub lines { return $_[0]->{'lines'}; }
};

package Clock::LargeNumber {

    sub new {
        my ( $class, $n ) = @_;
        my %lines;
        my $t = tie %lines, 'Tie::IxHash';
        %lines = (
            0 => "",
            1 => "",
            2 => "",
            3 => "",
            4 => "",
            5 => "",
            6 => "",
            7 => "",
            8 => ""
        );

        my $self = {
            lines => \%lines,
            n     => $n
        };
        return bless $self, $class;
    }

    sub add_str {
        my ( $self, $key, $stg ) = @_;
        $self->{'lines'}->{$key} = $stg;
    }

    sub add_to_buffer {
        my $self = shift;
        for my $n ( 0 .. 8 ) {
            my $lines = $buf->lines->{$n} . '' . $self->{lines}->{$n};
            $buf->set_line( $n, $lines );
        }
    }
};
__END__
-0
 ###### 
###  ###
##    ##
##    ##
##    ##
##    ##
##    ##
###  ###
 ###### 
-1
   ##   
   ##   
   ##   
   ##   
   ##   
   ##   
   ##   
   ##   
   ##   
-2
 ###### 
##    ##
      ##
      ##
########
##      
##      
##    ##
########
-3
 ###### 
##    ##
      ##
      ##
 #######
      ##
      ##
##    ##
 ###### 
-4
##    ##
##    ##
##    ##
##    ##
 #######
      ##
      ##
      ##
      ##
-5
########
##     #
##      
##      
########
      ##
      ##
##    ##
 ###### 
-6
 ###### 
##    ##
##      
##      
####### 
##    ##
##    ##
##    ##
 ###### 
-7
########
#     ##
      ##
      ##
  ######
      ##
      ##
      ##
      ##
-8
 ###### 
##    ##
#      #
##    ##
 ###### 
##    ##
#      #
##    ##
 ###### 
-9
 ###### 
##    ##
#      #
##    ##
 #######
      ##
      ##
##    ##
 ###### 
-:
    
 ## 
 ## 
 ## 
    
 ## 
 ## 
 ## 
    
