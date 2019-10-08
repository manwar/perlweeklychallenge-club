Running Mkbootstrap for ch_2_pl_0212 ()
chmod 644 "ch_2_pl_0212.bs"
"/home/jacoby/perl5/perlbrew/perls/perl-5.30.0/bin/perl" -MExtUtils::Command::MM -e 'cp_nonempty' -- ch_2_pl_0212.bs blib/arch/auto/ch_2_pl_0212/ch_2_pl_0212.bs 644
"/home/jacoby/perl5/perlbrew/perls/perl-5.30.0/bin/perl" "/home/jacoby/perl5/perlbrew/perls/perl-5.30.0/lib/5.30.0/ExtUtils/xsubpp"  -typemap "/home/jacoby/perl5/perlbrew/perls/perl-5.30.0/lib/5.30.0/ExtUtils/typemap"   ch_2_pl_0212.xs > ch_2_pl_0212.xsc
mv ch_2_pl_0212.xsc ch_2_pl_0212.c
cc -c  -iquote"/home/jacoby/local/dev/perlweeklychallenge-club/challenge-029/dave-jacoby/perl5" -fwrapv -fno-strict-aliasing -pipe -fstack-protector-strong -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2   -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/home/jacoby/perl5/perlbrew/perls/perl-5.30.0/lib/5.30.0/x86_64-linux/CORE"   ch_2_pl_0212.c
In file included from ch_2_pl_0212.xs:3:0:
/home/jacoby/perl5/perlbrew/perls/perl-5.30.0/lib/5.30.0/x86_64-linux/CORE/XSUB.h:137:29: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘void’
 #  define XS_EXTERNAL(name) void name(pTHX_ CV* cv __attribute__unused__)
                             ^
ch_2_pl_0212.c:163:1: note: in expansion of macro ‘XS_EXTERNAL’
 XS_EXTERNAL(boot_ch_2_pl_0212); /* prototype to pass -Wmissing-prototypes */
 ^
Makefile:330: recipe for target 'ch_2_pl_0212.o' failed
make: *** [ch_2_pl_0212.o] Error 1
