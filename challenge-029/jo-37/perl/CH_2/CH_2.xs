#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <math.h>

MODULE = CH_2		PACKAGE = CH_2		

double
erf(x)
  double x
  PROTOTYPE: $
