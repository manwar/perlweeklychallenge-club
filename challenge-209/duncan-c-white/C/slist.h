// slist.h:	a sorted list of strings - a growable dynarray of string
//		pointers into a common string buffer (storage for which is
//		also maintained inside the slist), which can be used as a simple set

struct slist
{
	int cap;	// current capacity, i.e. allocated size of data
	int n;		// current number of entries in data (n<=cap)
	char **data;	// actual data, growable.  pointers into buf
	int bufcap;	// the allocated size of buf
	int buflen;	// the current amount of data stored in buf
	char *buf;	// the buffer of underlying data
};

typedef struct slist *slist;

// prototypes

extern slist make_slist( int cap, int bufcap );
extern void append_slist( slist s, char * item );
extern bool isin_slist( char * value, slist s );
extern bool overlap_slists( slist s1, slist s2 );
extern void union_slists( slist s1, slist s2 );
extern void print_slist( slist s, FILE * out );
extern void free_slist( slist s );
