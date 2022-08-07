extern bool debug;

extern void process_flag_noarg( char * name, int argc, char ** argv );
extern void process_onenumarg_default( char * name, int argc, char ** argv, int defvalue, int * n );
extern void process_onenumarg( char * name, int argc, char ** argv, int * n );
extern void process_twonumargs( char * name, int argc, char ** argv, int * m, int * n );
extern int process_listnumargs( char * name, int argc, char ** argv, int * arr, int maxel );
