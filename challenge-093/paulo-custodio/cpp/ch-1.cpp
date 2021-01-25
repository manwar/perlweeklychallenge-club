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

#include <iostream>
#include <string>
#include <vector>

struct Point {
    int x, y;
};

int npoints_in_line(std::vector<Point>& points) {
    int max_npoints = 2;

    // for each pair of points forming a line, check if the other points fall on the line
    for (size_t i = 0; i < points.size() - 1; i++) {
        for (size_t j = i + 1; j < points.size(); j++) {
            // check each pair
            int npoints = 2;
            if (points[i].x == points[j].x && points[i].y == points[j].y) {
                std::cerr << "points must be different" << std::endl;
                exit(EXIT_FAILURE);
            }

            // check all other points
            for (size_t k = 0; k < points.size(); k++) {
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
    std::vector<Point> points;

    // check input arguments
    if ((argc - 1) < 4 || ((argc - 1) & 1) == 1) {
        std::cerr << "Usage: ch-1 x y x y x y ..." << std::endl;
        return EXIT_FAILURE;
    }

    // read points array from argv[]
    for (int i = 1; i + 1 < argc; i += 2) {
        Point p;
        p.x = atoi(argv[i]);
        p.y = atoi(argv[i + 1]);
        points.push_back(p);
    }

    // compute number of points in line
    int npoints = npoints_in_line(points);
    std::cout << npoints << std::endl;

    return EXIT_SUCCESS;
}
