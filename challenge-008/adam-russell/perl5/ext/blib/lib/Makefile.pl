# File : Makefile.PL
use ExtUtils::MakeMaker;
WriteMakefile(
    "NAME"    => "Perfect",                  # Name of package
    "OBJECT"  => "perfect.o perfect_wrap.o"  # Object files
);
