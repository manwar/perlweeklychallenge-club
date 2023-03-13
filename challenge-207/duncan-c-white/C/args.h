extern bool debug;

extern void process_flag_noarg( char * name, int argc, char ** argv );
extern int process_flag_n_args( char * name, int argc, char ** argv, int n, char * argmsg );
extern int process_flag_n_m_args( char * name, int argc, char ** argv, int min, int max, char * argmsg );
extern void process_onenumarg_default( char * name, int argc, char ** argv, int defvalue, int * n );
extern void process_onenumarg( char * name, int argc, char ** argv, int * n );
extern void process_twonumargs( char * name, int argc, char ** argv, int * m, int * n );
extern int process_listnumargs( char * name, int argc, char ** argv, int * arr, int maxel );
extern bool check_unsigned_int( char * val, int * n );
extern bool check_unsigned_real( char * val, double * n );
