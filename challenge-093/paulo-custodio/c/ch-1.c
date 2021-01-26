/*
Challenge 093

TASK #1 › Max Points
Submitted by: Mohammad S Anwar
You are given set of co-ordinates @N.

Write a script to count maximum points on a straight line when given co-ordinates plotted on 2-d plane.

Example 1:
|
|     x
|   x
| x
+ _ _ _ _

Input: (1,1), (2,2), (3,3)
Output: 3
Example 2:
|
|
| x       x
|   x
| x   x
+ _ _ _ _ _

Input: (1,1), (2,2), (3,1), (1,3), (5,3)
Output: 3
*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct Point {
    int x, y;
} Point;

int npoints_in_line(Point* points, size_t points_size) {
    int max_npoints = 2;

    // for each pair of points forming a line, check if the other points fall on the line
    for (size_t i = 0; i < points_size-1; i++) {
        for (size_t j = i+1; j < points_size; j++) {
            // check each pair
            int npoints = 2;
            if (points[i].x == points[j].x && points[i].y == points[j].y) {
                fprintf(stderr, "points must be different\n");
                exit(EXIT_FAILURE);
            }

            // check all other points
            for (size_t k = 0; k < points_size; k++) {
                if (k != i && k != j) {
                    // compute cross product
                    int dxc = points[k].x - points[i].x;
                    int dyc = points[k].y - points[i].y;

                    int dxl = points[j].x - points[i].x;
                    int dyl = points[j].y - points[i].y;

                    int cross = dxc * dyl - dyc * dxl;
                    if (cross == 0)     // Point Pk lies in line [Pi,Pj]
                        npoints++;
                }
            }
            if (npoints > max_npoints) {
                max_npoints = npoints;
            }
        }
    }

    return max_npoints;
}

int main(int argc, char* argv[]) {
    Point* points;
    size_t points_size;

    // check input arguments
    if ((argc-1) < 4 || ((argc-1)&1) == 1) {
        fprintf(stderr, "Usage: ch-1 x y x y x y ...\n");
        return EXIT_FAILURE;
    }

    // allocate memory for the point array and read it from argv[]
    points_size = (argc-1)/2;
    points = calloc(points_size, sizeof(Point));
    assert(points);
    for (size_t i = 0; i < points_size; i++) {
        points[i].x = atoi(argv[1+2*i]);
        points[i].y = atoi(argv[1+2*i+1]);
    }

    // compute number of points in line
    int npoints = npoints_in_line(points, points_size);
    printf("%d\n", npoints);

    free(points);
    return EXIT_SUCCESS;
}
