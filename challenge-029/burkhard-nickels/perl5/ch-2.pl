#!/usr/bin/perl

use strict;
use warnings;

my $tmp = "tmp";
if(!-d $tmp) { 
	mkdir $tmp;
	print "Created folder $tmp!\n";
	# die "Error: Folder tmp/ does not exist!"; 
}

BEGIN {
	$ENV{LD_LIBRARY_PATH}="tmp";
	my $ret = qx[ echo \$LD_LIBRARY_PATH; export \$LD_LIBRARY_PATH ];
	print "ENV: $ret\n";
}

# --------------------------------------------------
my $bn = "pwc29";
my $title = "Perl Weekly Challenge #029";

my $css = <<END_CSS;
body { margin-left:auto; margin-right:auto; width:80%; }
h1   { border-bottom:4px solid red; }
h2   { border-bottom:2px solid orange; }
pre  { border:2px solid grey; background-color:#eef; padding:10px; }
li   { padding:5px; }
a    { text-decoration:none; color:black; padding:4px; }
a:hover { background-color: brown; color:white; }
._podblock_ { width:100%; background-color:black; color:white; padding:10px; }
END_CSS


sub create_html {
	print "Create Web ...\n";
	open(my $fh,">$bn.css") or die "Cant open $bn.css!\n";
	print $fh $css;
	close $fh;
	print "\t$bn.css created!\n";
	my $ret = qx[pod2html --header --title="$title" --css=$bn.css $bn.pl > $bn.html];
	print "\t$bn.html created!\n";
}


# --------------------------------------------------
=head1 Perl Weekly Challenge #029 

I want to try the Perl Weekly Challenge. During I am working on it, I get
more and more ideas what to do next. So I decided to put all of the work in
only one file. The result is this one and only file "pwd29.pl" for several solutions.

The tasks for my first Perl Weekly Challenge are:

Task #1: Write a script to demonstate brace expansion.

Task #2: Write a script to demonstate calling a C function.

=head1 In brief

Cite from the Song "Ich weiss was ich will" from Udo Juergens: 
"Ich hab noch nie in meinem Leben Berge versetzt, ich tu'es jetzt."
(chuck, 12.10.2019)

I will do the following trials:

=over 4

=item * Task #1 and #2, Documentation on PWC

I created an inline documentation in POD format. With arg "html" pod2html is
executed to convert the POD to HTML. The files "pwc29.css" and "pwc29.html"
are created.

 # perldoc pwc29.pl
   or
 # ./pwc29.pl html

=item * Task #1, Brace expansion 1: Pattern matching and split

 # ./pwc29.pl brace1 "Perl {Daily,Weekly,Monthly} Challenge"

=item * Task #1, Brace expansion 2: Code compressed

 # ./pwc29.pl brace1 "Perl {Daily,Weekly,Monthly} Challenge"

=item * Task #1 and #2, Brace expansion 3: C Inline

The C function brex() is created and used with the "Inline" module.

 # ./pwc29.pl brace3 "Perl {Daily,Weekly,Monthly} Challenge"

=item * Task #1 and #2, Brace expansion 4: External C program system call

The main C function is created and written to file "brex.c" together with
the former created "brex()" function. Than the C program "brex" and C library
libbrex.so are created with gcc.

 # ./pwc29.pl brace4 "Perl {Daily,Weekly,Monthly} Challenge"

=item * Task #1 and #2, Brace expansion 5 and 6; C-Code with XS

The Brex.pm Perl Module with XS-Loader and the Brex.xs file to create
the interface module are created with arg "brace5". With arg "brace6"
the new Perl XS code is executed.

 # ./pwc29.pl brace5 "Perl {Daily,Weekly,Monthly} Challenge"
	and
 # ./pwc29.pl brace6 "Perl {Daily,Weekly,Monthly} Challenge"

=back

=cut

# -----------------------------------------------------------------
=head1 Task #1 - Brace expansion 1: Pattern matching and split

Also the shell is doing brace expansion, so I need to put the whole
string in double quotes.

 ./pwc29.pl brace1 "Perl {Daily,Weekly,Monthly} Challenge"
 IN: Perl {Daily,Weekly,Monthly} Challenge
 Perl  Daily  Challenge
 Perl  Weekly  Challenge
 Perl  Monthly  Challenge

The perl script is only doing pattern matching and split the list
of comma separated strings.

 my $str = $ARGV[0] || die "Error: String not set!\n";
 print "IN: $str\n";

 $str =~ /^(.*)\{(.*)\}(.*)/ || die "No braces in string!\n";
 my ($a,$b,$c) = ($1,$2,$3);
 my @ele = split(",",$b);

 foreach my $e (@ele) { print "$a $e $c\n"; }

=cut

sub brace_expansion_1 {

	my $str = shift || die "Error: String not set!\n";
	print "IN: $str\n";

	$str =~ /^(.*)\{(.*)\}(.*)/ || die "No braces in string!\n";
	my ($a,$b,$c) = ($1,$2,$3);
	my @ele = split(",",$b);

	foreach my $e (@ele) {
		print "$a $e $c\n";
	}
}

# -----------------------------------------------------------------

=head1 Task #1 - Brace expansion 2: Code compressed

The second verion of brace expansion is only a compressed version written
on two lines. I was not really able to make it a simple one-liner.

 my ($a,$b,$c) = $ARGV[0] =~ /^(.*)\{(.*)\}(.*)/;
 foreach my $e (split(",",$b)) { print "$a $e $c\n"; }

The script is called with arg one "brace2"

 ./pwc29.pl brace2 "Perl {Daily,Weekly,Monthly} Challenge"
 Perl  Daily  Challenge
 Perl  Weekly  Challenge
 Perl  Monthly  Challenge

=cut

sub brace_expansion_2 {
	my $str = shift || die "Error: String not set!\n";
	my ($a,$b,$c) = $str =~ /^(.*)\{(.*)\}(.*)/;
	foreach my $e (split(",",$b)) { print "$a $e $c\n"; }
}

# -----------------------------------------------------------------
=head1 Task #1 and #2 - Brace expansion 3: C Inline

The "Inline" Perl Module offers an easy way to call a C function from Perl.
To learn about it use perldoc:

 # perldoc Inline

=head2 C-Code for Inline

So first I wrote the "brex()" function in C. Then I called the C function with the use
of the Inline Module. Here I had some difficulties, beside the difficulties I
had with too low C knowledge. My C code must be in a BEGIN{} section to be available
at perl compile time. And within my C code are backslashes that needed to be masked
with an extra backslash. I.e. '\0' becomes '\\0' or 'printf("%s %s %s\n", a, tmp, c);'
becomes 'printf("%s %s %s\\n", a, tmp, c);'

 my $code_sub;
 BEGIN {
	$code_sub = <<END_C_SUB;

 void without_braces (char* str, char* res) { 
	int len = strlen(str)-2;
	strncpy(res,str+1,len);
	*(res+len)   = ',';
	*(res+len+1) = '\\0';
 }

 void brex(char* a, char* b, char* c) {
	char list[50];			// String without curly braces and extra comma
	without_braces(b,list);

	char* ref  = list;
	char* nref = strchr(ref,',');
	int   pos=0;
	do {
		char tmp[20];
		pos = nref - ref;

		strncpy(tmp,ref,pos);
		printf("%s %s %s\\n", a, tmp, c);
		ref += pos+1;

	} while ((nref = strchr(ref,',')) != NULL);
 }
 END_C_SUB
 }

=head2 Perl Code with Inline

The "use Inline" is compiling the C-Code. Afterwards the C function can
be called in Perl. The "Inline" module seems also to create XS code for me.
When you look into the "_Inline/" folder you can see the created temporary
files.

 use Inline C => $code_sub;
 my ($a,$b,$c) = $ARGV[0] =~ /^(.*)(\{.*\})(.*)/;
 brex($a,$b,$c);

Now I can execute the program:

 ./pwc29.pl brace3 "Perl {Daily,Weekly,Monthly} Challenge"
 Perl  Daily  Challenge
 Perl  Weekly  Challenge
 Perl  Monthly  Challenge

=cut

my $code_sub;

BEGIN {
	$code_sub = <<END_C_SUB;

void without_braces (char* str, char* res) { 
	int len = strlen(str)-2;
	strncpy(res,str+1,len);
	*(res+len)   = ',';
	*(res+len+1) = '\\0';
}

void brex(char* a, char* b, char* c) {
	char list[50];			// String without curly braces and extra comma
	without_braces(b,list);

	char* ref  = list;
	char* nref = strchr(ref,',');
	int   pos=0;
	do {
		char tmp[20];
		pos = nref - ref;

		strncpy(tmp,ref,pos);
		printf("%s %s %s\\n", a, tmp, c);
		ref += pos+1;

	} while ((nref = strchr(ref,',')) != NULL);
}
END_C_SUB
}

use Inline C => $code_sub;

sub brace_expansion_3 {
	my $str = shift || die "Error: String not set!\n";
	my ($a,$b,$c) = $str =~ /^(.*)(\{.*\})(.*)/;
	brex($a,$b,$c);
}

# -----------------------------------------------------------------
=head1 Task #1 and #2 - Brace expansion 4: External C program system call

This is about an external C library used within Perl with XS code.
I start this with writing the previous C code to file and compile
it as C executable "brex" and C shared library brex.so. And I verify
if the external program "brex" is executed properly.

 # ./pwc29.pl brace4 "Perl {Daily,Weekly,Monthly} Challenge"
 Command: gcc -fPIC -c tmp/brex.c -o tmp/brex.o
 Command: gcc tmp/brex.o -o tmp/brex
 Command: gcc -shared tmp/brex.o -L/usr/local/lib -o tmp/libbrex.so
 Command: tmp/brex Perl  "{Daily,Weekly,Monthly}"  Challenge
 IN: 4 - tmp/brex Perl {Daily,Weekly,Monthly} Challenge
 Perl Daily Challenge
 Perl Weekly Challenge
 Perl Monthly Challenge

=head2 The C Code for main()

A C program needs the main() function. This main function is stored in a perl
variable. The code must be available during perl compile time, so it is surrounded
by a BEGIN {} block. The main() function is only calling the brex() function
that we discussed in the former chapter.

 my $code_main;

 BEGIN {
	$code_main = <<END_C_MAIN;

 #include <stdio.h>
 #include <string.h>

 void brex(char*,char*,char*);

 int main( int argc, char** argv ) {
	printf("IN: %d - %s %s %s %s\\n",argc, argv[0], argv[1], argv[2], argv[3]);
	brex(argv[1],argv[2],argv[3]);
 }
 END_C_MAIN
 }

=head2 The Perl code with system call

A system call with perl function "qx()" is used to compile the
C code and to call the resulting "brex" program. In the C code before
we needed to mask the backslash. Now we have to substitute the backslash
again. Why? Because otherwise the code is not working. Try and Error.

I also do this to create an external C shared library for the XS trial below.

C Code from $code_main and $code_sub is written to tmp/brex.c

gcc creates tmp/brex.o, tmp/brex, tmp/libbrex.so

C program is executed with command:
 tmp/brex Perl "{Daily,Weekly,Monthly}" Challenge


 my $LIB1= "/usr/local/lib";

 sub brace_expansion_4 {
	my $str = shift || die "Error: String not set!\n";
	my ($a,$b,$c) = $str =~ /^(.*)(\{.*\})(.*)/;

	# ------ Write C code to file ----------
	open(my $fh, ">tmp/brex.c") or die "Error: Cant open brex.c!\n";
	$code_sub =~ s/\\\\/\\/g;
	$code_main =~ s/\\\\/\\/g;
	print $fh "$code_main\n$code_sub\n";
	close $fh;
	
	my @com = (
		"gcc -fPIC -c tmp/brex.c -o tmp/brex.o",
		"gcc tmp/brex.o -o tmp/brex",
		"gcc -shared tmp/brex.o -L$LIB1 -o tmp/libbrex.so",
		"tmp/brex $a \"$b\" $c",
	);
	foreach my $c (@com) { print "Command: $c\n"; my $ret = qx[$c]; print $ret; }
 }

=cut

my $code_main;

BEGIN {
	$code_main = <<END_C_MAIN;

#include <stdio.h>
#include <string.h>

void brex(char*,char*,char*);

int main( int argc, char** argv ) {
	printf("IN: %d - %s %s %s %s\\n",argc, argv[0], argv[1], argv[2], argv[3]);
	brex(argv[1],argv[2],argv[3]);
}
END_C_MAIN
}

my $LIB1= "/usr/local/lib";

sub brace_expansion_4 {
	my $str = shift || die "Error: String not set!\n";
	my ($a,$b,$c) = $str =~ /^(.*)(\{.*\})(.*)/;

	# ------ Write C code to file ----------
	open(my $fh, ">tmp/brex.c") or die "Error: Cant open brex.c!\n";
	$code_sub =~ s/\\\\/\\/g;
	$code_main =~ s/\\\\/\\/g;
	print $fh "$code_main\n$code_sub\n";
	close $fh;
	
	my @com = (
		"gcc -fPIC -c tmp/brex.c -o tmp/brex.o",
		"gcc tmp/brex.o -o tmp/brex",
		"gcc -shared tmp/brex.o -L$LIB1 -o tmp/libbrex.so",
		"tmp/brex $a \"$b\" $c",
	);
	foreach my $c (@com) { print "Command: $c\n"; my $ret = qx[$c]; print $ret; }
}

# -----------------------------------------------------------------
=head1 Task #1 and #2 - Brace expansion 5: C code with XS

We use our external library libbrex.so for the Perl Module Brex.pm.
So we write a XS file "Brex.xs" that calls the brex() function from
our libbrex.so library. The Brex.pm is dynamically loading the Brex.so
library that was created from the Brex.xs file.

Because this is a not very easy thing, and I also do not know much about
it, it is better to investigate in the appropriate XS docu:

 # perldoc perlxs
 # perldoc perlxstut
 # perldoc Module::Load::Conditional

=cut

my ($code_module,$code_xs);

=head2 Perl XS file

Here the XS code is stored in a perl variable. In the following program
this is written to the file "tmp/Brex.xs". The XS code is for translating
perl data types to C data types and vice versa. This is done by the "xsubpp",
the "XS subroutine pre-processor".

Here we state the C brex() function from our formerly created external libbrex.so
and the input and output variables. The "template" is used to translate the vars.

 $code_xs =<<CODE_XS_END;
 #define PERL_NO_GET_CONTEXT
 #include "EXTERN.h"
 #include "perl.h"
 #include "XSUB.h"
 #include "ppport.h"
 extern void brex(char*,char*,char*);
 MODULE = Brex             PACKAGE = Brex
 PROTOTYPES: ENABLE
 void 
 brex(a,b,c)
 	char* a
 	char* b
 	char* c
 CODE_XS_END

=cut

$code_xs =<<CODE_XS_END;
#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"
extern void brex(char*,char*,char*);
MODULE = Brex             PACKAGE = Brex
PROTOTYPES: ENABLE
void 
brex(a,b,c)
	char* a
	char* b
	char* c
CODE_XS_END

=head2 Perl Module with XS Loader

Here the Perl Module code for XS is stored in a perl variable. In the following program
this is written to the file "tmp/Brex.pm". This code is loading the Brex.so interface
library.

 $code_module =<<CODE_MOD_END;
 package Brex;
 
 require Exporter;
 our \@ISA = qw(Exporter);
 our \@EXPORT = qw( );
 our \$VERSION = '0.01';
 
 require XSLoader;
 XSLoader::load('Brex', \$VERSION);
 
 1;
 CODE_MOD_END

=cut


$code_module =<<CODE_MOD_END;
package Brex;

require Exporter;
our \@ISA = qw(Exporter);
our \@EXPORT = qw( );
our \$VERSION = '0.01';

require XSLoader;
XSLoader::load('Brex', \$VERSION);

# Preloaded methods go here.
1;
CODE_MOD_END


my $INC1= "/usr/lib/x86_64-linux-gnu/perl/5.24/CORE";
my $INC2= "/usr/local/include";
my $INC3= "/usr/local/lib/x86_64-linux-gnu/perl/5.24.1/PDL/Core";
my $PP  = "/usr/local/bin/xsubpp";
my $TM  = "/usr/share/perl/5.24.1/ExtUtils/typemap";

=head2 Creation of XS Module Brex.pm

The tools gcc and xsubpp are executed with perl system calls with
the function "qx()". So the arg "brace5" is only for writing the file
"tmp/Brex.pm" and "tmp/Brex.xs" and for compiling the XS code.

 my $INC1= "/usr/lib/x86_64-linux-gnu/perl/5.24/CORE";
 my $INC2= "/usr/local/include";
 my $INC3= "/usr/local/lib/x86_64-linux-gnu/perl/5.24.1/PDL/Core";
 my $PP  = "/usr/local/bin/xsubpp";
 my $TM  = "/usr/share/perl/5.24.1/ExtUtils/typemap";

 sub brace_expansion_5 {
	my $str = shift || die "Error: String not set!\n";
	my ($a,$b,$c) = $str =~ /^(.*)(\{.*\})(.*)/;

	# ------ Write  code to file ----------
	open(my $fh, ">tmp/Brex.pm") or die "Error: Cant open tmp/Brex.pm!\n";
	print $fh "$code_module\n";
	close $fh;
	open($fh, ">tmp/Brex.xs") or die "Error: Cant open tmp/Brex.xs!\n";
	print $fh "$code_xs\n";
	close $fh;

	my @com = (
		"perl $PP -typemap $TM tmp/Brex.xs > tmp/Brex.xsc",
		"mv tmp/Brex.xsc tmp/Brex.c",
		"gcc -fPIC -I$INC1 -I$INC2 -I$INC3 -c tmp/Brex.c -o tmp/Brex.o",
		"gcc -shared -L$LIB1 -L. -lbrex tmp/Brex.o -o tmp/libBrex.so",
	);
	foreach my $c (@com) { print "$c\n"; my $ret = qx[$c]; print $ret; }
 }
=cut

sub brace_expansion_5 {
	my $str = shift || die "Error: String not set!\n";
	my ($a,$b,$c) = $str =~ /^(.*)(\{.*\})(.*)/;

	# ------ Write  code to file ----------
	open(my $fh, ">tmp/Brex.pm") or die "Error: Cant open tmp/Brex.pm!\n";
	print $fh "$code_module\n";
	close $fh;
	open($fh, ">tmp/Brex.xs") or die "Error: Cant open tmp/Brex.xs!\n";
	print $fh "$code_xs\n";
	close $fh;

	my @com = (
		"perl $PP -typemap $TM tmp/Brex.xs > tmp/Brex.xsc",
		"mv tmp/Brex.xsc tmp/Brex.c",
		"gcc -fPIC -I$INC1 -I$INC2 -I$INC3 -c tmp/Brex.c -o tmp/Brex.o",
		"gcc -shared -L$LIB1 -Ltmp -lbrex tmp/Brex.o -o tmp/libBrex.so",
	);
	foreach my $c (@com) { print "Command: $c\n"; my $ret = qx[$c]; print $ret; }
}

=head2 Usage of Brex.pm

Before we created the C-Code XS Module Brex.pm, now we use it.
We simply call the Perl function "Brex::brex($a,$b,$c)". The only
difficulty here is the "use Brex.pm" statement. We can not use it here
because otherwise we get a compile error, when Brex.pm is not created before.
And this is the case here, because this same script shall create it.
So here the Module "Module::Load::Conditional" with its funcion "can_load()"
is used.

In the BEGIN block the LD_LIBRARY_PATH must be set. It also can be set
in the shell before executing this script.

 BEGIN {
	$ENV{LD_LIBRARY_PATH}="tmp";
	my $ret = qx[ echo \$LD_LIBRARY_PATH; export \$LD_LIBRARY_PATH ];
	print "ENV: $ret\n";
 }

 sub brace_expansion_6 {
	my $str = shift || die "Error: String not set!\n";
	my ($a,$b,$c) = $str =~ /^(.*)(\{.*\})(.*)/;

	use lib 'tmp';

	# --- Conditional execution, if module can be loaded
	if(my $ret = require "Brex.pm") { Brex::brex($a,$b,$c); }
	else { die "Error: Perl Module tmp/Brex.pm not available ($ret)!\n"; }

	# --- Conditional execution, if module can be loaded
	# this somehow did NOT work:
	use Module::Load::Conditional qw[can_load];
	if(can_load(modules=>"Brex")) {
		Brex::brex($a,$b,$c);
	}
	else { die "Error: Perl Module tmp/Brex.pm not available!\n"; }
 }

=head2 Executing XS code

The XS code ist executed. The LD_LIBRARY_PATH is now also set in the code of
this script in a BEGIN block, see above. So this export statement is not necessary.

 # export LD_LIBRARY_PATH=tmp
 # ./pwc29.pl brace6 "Perl {Daily,Weekly,Monthly} Challenge"
 ENV: tmp

 Perl  Daily  Challenge
 Perl  Weekly  Challenge
 Perl  Monthly  Challenge

=cut

sub brace_expansion_6 {
	my $str = shift || die "Error: String not set!\n";
	my ($a,$b,$c) = $str =~ /^(.*)(\{.*\})(.*)/;

	use lib 'tmp';

	# use Brex;
	# Brex::brex($a,$b,$c);

	if(my $ret = require "Brex.pm") { Brex::brex($a,$b,$c); }
	else { die "Error: Perl Module tmp/Brex.pm not available ($ret)!\n"; }

	# use Module::Load::Conditional qw[can_load];
	# if(can_load(modules=>"lib/Brex.pm")) {
	# 	Brex::brex($a,$b,$c);
	# }
	# else { die "Error: Perl Module tmp/Brex.pm not available!\n"; }
}

# --------------------------------------------------

if($ARGV[0] eq "html") { create_html(); }
elsif($ARGV[0] eq "brace1") { brace_expansion_1($ARGV[1]); }
elsif($ARGV[0] eq "brace2") { brace_expansion_2($ARGV[1]); }
elsif($ARGV[0] eq "brace3") { brace_expansion_3($ARGV[1]); }
elsif($ARGV[0] eq "brace4") { brace_expansion_4($ARGV[1]); }
elsif($ARGV[0] eq "brace5") { brace_expansion_5($ARGV[1]); }
elsif($ARGV[0] eq "brace6") { brace_expansion_6($ARGV[1]); }

# --------------------------------------------------

=head1 AUTHOR

chuck

=cut


