#!/usr/bin/perl

#+----------------------------------------------------------------------
#| Copyright (c) 2012, 2013, 2014 Genome Research Ltd.
#| This file is part of the Pagesmith web framework.
#+----------------------------------------------------------------------
#| The Pagesmith web framework is free software: you can redistribute
#| it and/or modify it under the terms of the GNU Lesser General Public
#| License as published by the Free Software Foundation; either version
#| 3 of the License, or (at your option) any later version.
#|
#| This program is distributed in the hope that it will be useful, but
#| WITHOUT ANY WARRANTY; without even the implied warranty of
#| MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#| Lesser General Public License for more details.
#|
#| You should have received a copy of the GNU Lesser General Public
#| License along with this program. If not, see:
#|     <http://www.gnu.org/licenses/>.
#+----------------------------------------------------------------------

## Move stuff from trunk to stage....
## Author         : js5
## Maintainer     : js5
## Created        : 2009-08-12
## Last commit by : $Author: js5 $
## Last modified  : $Date: 2014-08-20 10:26:06 +0100 (Wed, 20 Aug 2014) $
## Revision       : $Revision: 1907 $
## Repository URL : $HeadURL: svn+psssh://pagesmith-core@web-wwwsvn/repos/svn/pagesmith/pagesmith-core/trunk/utilities/original-spreadsheet-code.pl $

use strict;
use warnings;
use utf8;

use version qw(qv); our $VERSION = qv('0.1.0');

use Const::Fast qw(const);

const my $MAX_VALUE => 10;

sub FORMAT_BOLD       { return 'format' => sub { return "<b>$_[0]</b>" } }
sub FORMAT_ITALIC     { return 'format' => sub { return "<i>$_[0]</i>" } }
sub FORMAT_BOLDITALIC { return 'format' => sub { return "<b><i>$_[0]</i></b>" } }

sub TOTAL_BOLD       { return 'total' => sub { return "<b>$_[0]</b>" } }
sub TOTAL_ITALIC     { return 'total' => sub { return "<i>$_[0]</i>" } }
sub TOTAL_BOLDITALIC { return 'total' => sub { return "<b><i>$_[0]</i></b>" } }

sub FORMAT_NDP        { my $T = shift; return sub { return sprintf "%0.${T}f", $_[0] } }
sub FORMAT_CURRENCY   { return 'align' => 'right', 'format' => sub { return sprintf '&pound;%0.2f', shift } }
sub FORMAT_INTEGER    { return 'align' => 'right' }
sub FORMAT_2DP        { return 'align' => 'right', 'format' => FORMAT_NDP(2) }

## no critic (CheckedSyscalls)

print "Content-type: text/html\n\n";

print '<html><head><!-- OK --><style> th { background-color: #ffdf27; } .c1 td { background-color: #ffffcc } .c2 td { background-color: #ffffe8 }</style></head><body>';
my $i;
print produce_table(
  [
    { 'key'=>'x1', 'title'=>'X', 'width'=>'16%' },
    { 'key'=>'x2', 'title'=>'X^2', 'width'=>'16%', FORMAT_CURRENCY },
    { 'key'=>'x3', 'title'=>'X^3', 'width'=>'16%', FORMAT_INTEGER },
    { 'key'=>'x4', 'title'=>'X^4', 'width'=>'16%', FORMAT_2DP },
    { 'key'=>'x5', 'title'=>'X^5', 'width'=>'16%', FORMAT_BOLD },
    { 'key'=>'xh', 'title'=>'sqrt(X)', 'width'=>'20%', FORMAT_2DP },
  ],
  [ map { Test->new($_) } 1..$MAX_VALUE ],
  { 'width' => '50%' },
);

$i = 0;
print produce_table(
  [
    { 'key'=>'c', 'title'=>'Amount', 'align' => 'center', 'format' => sub { sprintf '<b>&pound;%0.2f</b>', $_[0]},  },
    { 'key'=>'index', 'title'=>'Index', },
    { 'key'=>'a', 'title'=>'x',      'align' => 'right', 'total' => 'CAPTION', },
    { 'key'=>'b', 'title'=>'x^2',    'align' => 'right', },
    { 'key'=>'d', 'title'=>'x^3',    'align' => 'right', },
    { 'key'=>'z', 'title'=>'x^4',    'align' => 'right', 'total' => sub { '&nbsp;'}  },
  ],
  [ map {{'z'=>$_*$_*$_*$_,'a'=>$_,'b'=>$_*$_,'c'=>"$_",'d'=>$_*$_*$_,'index'=>++$i}} 0..$MAX_VALUE ],
  { 'header' => 'no' },
);
$i = 0;
print produce_table(
  [
    { 'title'=>'Amount', 'align' => 'center', 'format' => sub { sprintf '<b>&pound;%0.2f</b>', $_[0]}  },
    { 'key'=>'index','title'=>'Index' },
    { 'key' => 'zzz', 'title'=>'x',      'align' => 'right',  TOTAL_BOLD },
    { 'key' => 'fred', 'title'=>'x^2',    'align' => 'right', TOTAL_BOLDITALIC },
    { 'title'=>'x^3',    'align' => 'right' },
    { 'title'=>'x^4',    'align' => 'right', 'total' => sub { '&nbsp;'}  },
  ],
  [ map {[ $_, ++$i, $_, $_*$_, $_*$_*$_, $_*$_*$_*$_ ]} 0..$MAX_VALUE ],
);

print produce_table(
  [
    { 'key'=>'c', 'title'=>'Amount', 'align' => 'center', 'format' => sub { sprintf '<b>&pound;%0.2f</b>', $_[0]}, 'total' => '<b>Total</b>', 'width'=>'50%'  },
    { 'key'=>'a', 'title'=>'x',      'align' => 'right' , TOTAL_BOLD , 'width'=>'20%' },
    { 'key'=>'b', 'title'=>'x^2',    'align' => 'right' , TOTAL_BOLDITALIC , FORMAT_ITALIC, 'width'=>'10%' },
    { 'key'=>'d', 'title'=>'x^3',    'align' => 'right' , TOTAL_BOLD, 'width' => '10%' },
    { 'key'=>'z', 'title'=>'x^4',    'align' => 'right' , TOTAL_BOLD, 'width' => '10%' },
  ],
  [ map {{'z'=>$_*$_*$_*$_,'a'=>$_,'b'=>$_*$_,'c'=>"$_",'d'=>$_*$_*$_}} 0..$MAX_VALUE ],
);

print '</body></html>';

## Produce table takes two / three parameters and produces an HTML table.
## parameter 1 - column descriptions
##   array of hashes
##   hash keys are:
##     'key'    - key of hash or access function of object
##     'title'  - caption to display in header row
##     'align'  - alignment (left / right / center )
##     'width'  - width of column
##     'format' - format code ref takes two parameters - column and row
##     'total'  - either code ref takes two parameters - column total and all totals
##                       string - displays as caption
##                       undef  - displays column total
## parameter 2 - data
##   array of either objects, hashes, or arrays
##   if object then "key" above is the name of an access function
##   if hash   then "key" above is key to hash
##   if array  then displayed in order of elements in array
## parameter 3 - additional configuration (optional)
##   optional hash
##     'rows' => array of styles used to format rows
##     'header' => 'no' <- do not display header row.
##     'align'  => alignment option for table (default centered)
##     'width'  => width option for table (default $MAX_VALUE0%)
##     'valign' => valignment option for rows (defaults to top)

sub produce_table{
  my( $C,$T ) = (0,{});
## no critic (ImplicitNewlines)
  return map {
    qq(<table cellpadding="2" cellspacing="0" align="@{[
      exists $_[2]{align} ?
        $_[2]{align} :
        'center'
    ]}" width="@{[
      exists $_[2]{width} ?
      $_[2]{width} :
      '$MAX_VALUE0%'
    ]}">@{[
      map( {
        $T->{$_->{key}||$C}=0 if exists $_->{total};
        $C++;
        ()
      }@{$_[0]} ), ($_[2]{'header'}||'' eq 'no' ?
        () :
        qq(<tr valign="middle">@{[
          map{
            $T->{$_->{key}||$C}=0 if exists $_->{total};
            $C++;
            qq(<th>$_->{title}</th>)
          }@{$_[0]}
        ]}</tr>))
    ]}@{[
      map{
        my $a=$_;
        $C=0;
        qq(<tr valign="@{[
          exists $_[2]{valign} ?
          $_[2]{valign} :
          'top'
        ]}" @{[
          exists $_[2]{rows} ?
            qq( class="@{[
              [ push( @{$_[2]{rows}},shift @{$_[2]{rows}}) , $_[2]{rows}[-1] ]->[1]
            ]}") :
            ''
        ]}>@{[
          map{
            my $b = ref($a) eq 'ARRAY' ?
              $a->[$C] :
              ref($a) eq 'HASH' ?
                $a->{$_->{key}} :
                $a->${\$_->{key}};
            exists $_->{total} and $T->{$_->{key}||$C}+=$b;
            $C++;
            qq(<td@{[
              $_->{align} ?
                qq( align="$_->{align}") :
                ''
            ]}@{[
              $_->{width} ?
                qq( width="$_->{width}") :
                ''
            ]}>@{[
              $b eq'' ?
                '&nbsp;' :
                $_->{format} ?
                  $_->{format}->($b,$a) :
                  $b
            ]}</td>)
          }@{$_[0]}
        ]}</tr>)
      }@{$_[1]}
    ]}@{[
      ($C=-1)&&%$T ?
        qq(<tr valign="@{[
          exists $_[2]{valign} ?
          $_[2]{valign} :
          'top'
        ]}">@{[
          map {
            $C++;
            qq(<td @{[
              $_->{align} ?
                qq( align="$_->{align}") :
                ''
            ]}>@{[
              !exists $_->{total} ?
                '&nbsp;' :
                ref $_->{total} eq 'CODE' ?
                  $_->{total}->($T->{$_->{key}||$C},$T) :
                  $_->{total} || $T->{$_->{key}||$C}
            ]}</td>)
          } @{$_[0]}
        ]}</tr>) :
        ''
    ]}</table>)
  } 1;
## use critic;
}

package Test;
  sub new {
    my( $class, $value ) = @_;
    my $self = { 'x'=>$value, 'y' => $value*2 };
    bless $self, $class;
    return $self;
  }
  sub x1 {  my $x = shift; my $v = $x->{'x'}; return $v; }
  sub x2 { my $x = shift; my $v = $x->{'x'}; return $v*$v; }
  sub x3 { my $x = shift; my $v = $x->{'x'}; return $v*$v*$v; }
  sub x4 { my $x = shift; my $v = $x->{'x'}; return $v*$v*$v*$v; }
  sub x5 { my $x = shift; my $v = $x->{'x'}; return $v*$v*$v*$v*$v; }
  sub xh { my $x = shift; my $v = $x->{'x'}; return sqrt $v; }
## use critic
1;

