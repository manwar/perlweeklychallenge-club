#! python3

import sys
from vininfo import Vin
from pprint import pprint

try:
    vin = Vin(sys.argv[1])
    pprint(vin.annotate())

except Exception as e:
    print('Error: %s' % e)
    sys.exit(1)

