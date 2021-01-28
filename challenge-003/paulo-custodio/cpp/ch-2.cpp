/*
Challenge 003

Challenge #2
Create a script that generates Pascal Triangle. Accept number of rows from
the command line. The Pascal Triangle should have at least 3 rows. For more
information about Pascal Triangle, check this wikipedia page.

*/

#include <iostream>
#include <string>
#include <vector>

void draw_pascal(int rows) {
    // allocate current and next row
    std::vector<int> data[2];
    for (int i = 0; i < 2; i++)
        data[i].resize(rows+1);

    int cur = 0;
    data[cur][0] = 1;
    for (int row = 1; row <= rows; row++) {
        // print current row
        for (int col = 0; col < rows-row; col++)
            std::cout << ' ';
        for (int col = 0; col < row; col++)
            std::cout << data[cur][col] << ' ';
        std::cout << std::endl;

        // compute next row
        int nxt = 1-cur;
        data[nxt][0] = 1;
        data[nxt][row] = 1;
        for (int col = 1; col < row; col++)
            data[nxt][col] = data[cur][col-1] + data[cur][col];
        cur = nxt;
    }
}

int main(int argc, char* argv[]) {
    if (argc == 2)
        draw_pascal(atoi(argv[1]));
}
