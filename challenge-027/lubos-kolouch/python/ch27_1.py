#! python3

import sys

def get_intersection(points):
    a = int(points[1])
    b = int(points[2])
    c = int(points[3])
    d = int(points[4])

    p = int(points[5])
    q = int(points[6])
    r = int(points[7])
    s = int(points[8])

    det = ( a - c ) * ( q - s ) - ( b - d ) * ( p - r )

    if det == 0:
        return 0

    # Let's assume the lines are infinitely long
    px = ( a * d - b * c ) * ( p - r ) - ( a - c ) * ( p * s - q * r ) / det;
    py = ( a * d - b * c ) * ( q - s ) - ( b - d ) * ( p * s - q * r ) / det;

    return ( [ px, py ] );

if len(sys.argv) != 9:
    print('Usage: ch-1.pl a b c d p q r s');
    sys.exit()

result = get_intersection(sys.argv)

print(result)
