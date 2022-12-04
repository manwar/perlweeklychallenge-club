#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>


bool debug = false;


// process_flag_noarg( name, argc, argv );
//	Process the -d flag, and check that there are no
//	remaining arguments.
void process_flag_noarg( char *name, int argc, char **argv )
{
	int arg=1;
	if( argc>1 && strcmp( argv[arg], "-d" ) == 0 )
	{
		debug = true;
		arg++;
	}

	int left = argc-arg;
	if( left != 0 )
	{
		fprintf( stderr, "Usage: %s [-d]\n", name );
		exit(1);
	}
}


// int argno = process_flag_n_args( name, argc, argv, n, argmsg );
//	Process the -d flag, and check that there are exactly
//	n remaining arguments, return the index position of the first
//	argument.  If not, generate a fatal Usage error using the argmsg.
//	
int process_flag_n_args( char *name, int argc, char **argv, int n, char *argmsg )
{
	int arg=1;
	if( argc>1 && strcmp( argv[arg], "-d" ) == 0 )
	{
		debug = true;
		arg++;
	}

	int left = argc-arg;
	if( left != n )
	{
		fprintf( stderr, "Usage: %s [-d] %s\n       Exactly %d "
			"arguments needed\n", name, argmsg, n );
		exit(1);
	}
	return arg;
}


// int argno = process_flag_n_m_args( name, argc, argv, min, max, argmsg );
//	Process the -d flag, and check that there are between
//	min and max remaining arguments, return the index position of the first
//	argument.  If not, generate a fatal Usage error using the argmsg.
//	
int process_flag_n_m_args( char *name, int argc, char **argv, int min, int max, char *argmsg )
{
	int arg=1;
	if( argc>1 && strcmp( argv[arg], "-d" ) == 0 )
	{
		debug = true;
		arg++;
	}

	int left = argc-arg;
	if( left < min || left > max )
	{
		fprintf( stderr, "Usage: %s [-d] %s\n       Between %d and %d "
			"arguments needed\n", name, argmsg, min, max );
		exit(1);
	}
	return arg;
}


// process_onenumarg_default( name, argc, argv, defvalue, &n );
//	Process the -d flag, and check that there is a single
//	remaining numeric argument (or no arguments, in which case
//	we use the defvalue), putting it into n
void process_onenumarg_default( char *name, int argc, char **argv, int defvalue, int *n )
{
	char argmsg[100];
	sprintf( argmsg, "[int default %d]", defvalue );
	int arg = process_flag_n_m_args( name, argc, argv, 0, 1, argmsg );

	*n = arg == argc ? defvalue : atoi( argv[arg] );
}


// process_onenumarg( name, argc, argv, &n );
//	Process the -d flag, and check that there is a single
//	remaining numeric argument, putting it into n
void process_onenumarg( char *name, int argc, char **argv, int *n )
{
	int arg = process_flag_n_args( name, argc, argv, 1, "int" );

	// argument is in argv[arg]
	*n = atoi( argv[arg] );
}


// process_twonumargs( name, argc, argv, &m, &n );
//	Process the -d flag, and check that there are 2
//	remaining numeric arguments, putting them into m and n
void process_twonumargs( char *name, int argc, char **argv, int *m, int *n )
{
	int arg = process_flag_n_args( name, argc, argv, 2, "int" );

	// arguments are in argv[arg] and argv[arg+1]
	*m = atoi( argv[arg++] );
	*n = atoi( argv[arg] );
}


// process_twostrargs() IS DEPRECATED: use process_flag_n_m_args() instead


// int arr[100];
// int nel = process_listnumargs( name, argc, argv, arr, 100 );
//	Process the -d flag, and check that there are >= 2
//	remaining numeric arguments, putting them into arr[0..nel-1]
//	and returning nel.
int process_listnumargs( char *name, int argc, char **argv, int *arr, int maxel )
{
	int arg=1;
	if( argc>1 && strcmp( argv[arg], "-d" ) == 0 )
	{
		debug = true;
		arg++;
	}

	int left = argc-arg;
	if( left < 2 )
	{
		fprintf( stderr, "Usage: %s [-d] list_of_numeric_args\n", name );
		exit(1);
	}
	if( left > maxel )
	{
		fprintf( stderr, "%s: more than %d args\n", name, maxel );
		exit(1);
	}

	// elements are in argv[arg], argv[arg+1]...

	if( debug )
	{
		printf( "debug: remaining arguments are in arg=%d, "
		        "firstn=%s, secondn=%s..\n",
			arg, argv[arg], argv[arg+1] );
	}

	int nel = 0;
	for( int i=arg; i<argc; i++ )
	{
		arr[nel++] = atoi( argv[i] );
	}
	arr[nel] = -1;
	return nel;
}


//
// bool isint = check_unsigned_int( char *val, int *n );
//	Given an string val, check that there's an unsigned integer
//	in it (after optional whitespace).  If there is a valid
//	unsigned integer value, store that integer value in *n and
//	return true; otherwise return false (and don't alter *n).
bool check_unsigned_int( char *val, int *n )
{
	// skip whitespace in val
	char *p;
	for( p=val; isspace(*p); p++ )
	{
		/*EMPTY*/
	}
	if( ! isdigit(*p) ) return false;
	*n = atoi(p);
	return true;
}


//
// bool ok = check_unsigned_real( char *val, double *n );
//	Given an string val, check that there's an unsigned real
//	in it (after optional whitespace).  If there is a valid
//	unsigned real value, store that value in *n and
//	return true; otherwise return false (and don't alter *n).
bool check_unsigned_real( char *val, double *n )
{
	// skip whitespace in val
	char *p;
	for( p=val; isspace(*p); p++ )
	{
		/*EMPTY*/
	}
	if( ! isdigit(*p) ) return false;
	*n = atof(p);
	return true;
}
