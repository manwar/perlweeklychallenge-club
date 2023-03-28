//
// Task 2: Merge Account
// 
// C version.
// 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>

#include "args.h"
#include "csvsplit.h"
#include "slist.h"


// int nch = countch( target, str );
//	Count and return the number of occurrences of the target character in str.
//
int countch( char target, char *str )
{
	int n=0;
	for( ; *str; str++ )
	{
		if( *str == target ) n++;
	}
	return n;
}


// extra is really an slist
static void addemail( char *value, void *s )
{
	append_slist( (slist)s, value );
}


// slist emails = splitcommas( emailstr );
//	form a sorted list of emails from emailstr,
//	duplicating the emailstr buffer inside the slist
//	emails will need freeing later
//
slist splitcommas( char *emailstr )
{
	int n = 1 + countch( ',', emailstr );
	slist s = make_slist( n, 100 );

	if( debug ) { printf( "emailstr %s, nemails = %d\n", emailstr, n ); }
	csvForeach( emailstr, &addemail, s );
	if( s->n != n ) { printf( "warning: sn=%d, n=%d\n", s->n, n ); }
	assert( s->n == n );

	if( debug )
	{
		printf( "debug: slist(emailstr %s) is ", emailstr );
		print_slist( s, stdout ); putchar( '\n' );
	}

	return s;
}


// int ne = 0;
// slist *emails = an slist[argc] array
// char *name = matchfirstname( &argc, argv, &ne, emails );
//	Extract the name from arg[0], and then find all matching
//	arg[i<nargs] (including arg[0] by definition), splitting the
//	email strings and storing the resultant slist in array emails[ne],
//	deleting them from arg[] and altering nargs.
//	Return (a strdup()d copy of) the name common to all;
//	The caller will need to free name later
//	
char *matchfirstname( int *nargs, char **arg, int *nm, slist *emails )
{
	char *comma = strchr( arg[0], ',' );
	assert( comma != NULL );
	*comma = '\0';
	char *name = strdup( arg[0] );
	assert( name != NULL );
	*comma = ',';			// change arg[0] back

	// now extract name + ',' as the strncmp argument for later
	char ch = *(comma+1);
	*(comma+1) = '\0';
	char *namepluscomma = strdup( arg[0] );
	assert( namepluscomma != NULL );
	*(comma+1) = ch;		// change arg[0] back

	int len = 1+comma-arg[0];
	if( debug )
	{
		printf( "debug: arg[0] = %s, name = %s, len inc comma=%d\n",
			arg[0], name, len );
	}

	int n = 0;
	int d = 0;
	emails[n++] = splitcommas( comma+1 );
	arg[0] = NULL;

	for( int i=1; i<*nargs; i++ )
	{
		if( strncmp(namepluscomma,arg[i],len)==0 )
		{
			char *comma2 = arg[i] + len - 1;
			assert( *comma2 == ',' );
			emails[n] = splitcommas( comma2+1 );
			if( debug )
			{
				printf( "debug: matched arg[%d] == %s, set emails[n] = ",
					i, arg[i] );
				print_slist( emails[n], stdout ); putchar( '\n' );
			}
			n++;
		} else
		{
			assert( arg[d] == NULL );
			arg[d++] = arg[i];
		}
		arg[i] = NULL;
	}
	free( namepluscomma );
	*nm = n;
	*nargs -= n;
	return name;
}


// dealwith( name, emails, ne );
//	Given a name and an array emails[ne] of slists from all
//	original arguments with THE SAME NAME as name,
//	deal with all output for the given name,
//	merging the email lists where possible, printing out one or
//	more name, emails lists as a result.
//
void dealwith( char *name, slist *emails, int ne )
{
	assert( ne > 0 );

	if( debug )
	{
		printf( "debug: merging %d lists\n", ne );
	}

	while( ne>0 )
	{
		slist s1 = emails[0];

		// remove emails[0]
		for( int i=1; i<ne; i++ )
		{
			emails[i-1] = emails[i];
		}
		ne--;

		if( debug )
		{
			printf( "debug: ne = %d, picked s1 = ", ne );
			print_slist( s1, stdout ); putchar( '\n' );
		}

		for( int i=0; i<ne; i++ )
		{
			slist s2 = emails[i];
			if( debug )
			{
				printf( "debug: s2 = emails[%d].s = ", i );
				print_slist( s2, stdout ); putchar( '\n' );
			}
			bool any = overlap_slists( s1, s2 );
			if( debug )
			{
				printf( "debug: any overlap between s1 and s2 (emails[%d])? %d\n",
					i, any );
			}
			if( any )
			{
				union_slists( s1, s2 );
				if( debug )
				{
					printf( "debug: have altered s1 to " );
					print_slist( s1, stdout ); putchar( '\n' );
				}

				// delete emails[i]
				for( int j=i+1; j<ne; j++ )
				{
					emails[j-1] = emails[j];
				}
				free_slist( s2 );
				ne--;
			}
		}
		// found an answer: s1..
		printf( "[\"%s\"", name );
		for( int i=0; i<s1->n; i++ )
		{
			printf( ", " );
			printf( "\"%s\"", s1->data[i] );
		}
		printf( "], " );
		free_slist( s1 );

		if( debug )
		{
			printf( "debug: remaining emails[] are: " );
			for( int j=0; j<ne; j++ )
			{
				if( j>0 ) putchar('-');
				print_slist( emails[j], stdout );
			}
			putchar( '\n' );
		}
	}
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "merge-accounts", argc, argv,
		1, 1000, "list(name,emails)" );

	argv += argno;		// reset base, so we now have argv[argc]..
	argc -= argno;

	for( int i=0; i<argc; i++ )
	{
		if( strchr(argv[i],',')==NULL )
		{
			fprintf( stderr, "Bad arg %s, no comma found\n", argv[i] );
			exit(1);
		}
	}

	if( debug )
	{
		printf( "argc=%d, first arg=%s\n", argc, argv[0] );
	}
	printf( "output: [ " );

	while( argc > 0 )
	{
		// find a set of email slists with matching names,
		// using the first argument to pick the name
		int ne = 0;
		slist *emails = malloc( argc * sizeof(slist) );
		assert( emails != NULL );
		char *name = matchfirstname( &argc, argv, &ne, emails );
		if( debug )
		{
			printf( "debug: ne=%d, ", ne );
			for( int i=0; i<ne; i++ )
			{
				printf( "debug: emails[%d] ", i );
				print_slist( emails[i], stdout ); putchar( '\n' );
			}
			printf( "debug: remaining argc=%d, ", argc );
			for( int i=0; i<argc; i++ )
			{
				printf( "debug: arg %d=%s\n", i, argv[i] );
			}
			printf( "debug: need to deal with @emails[%d]\n", ne );
		}
		dealwith( name, emails, ne );
		free( emails );
		free( name );
	}

	printf( " ]\n" );
	return 0;
}
