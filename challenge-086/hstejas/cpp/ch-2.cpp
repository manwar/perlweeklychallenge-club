#include <array>
#include <vector>
#include <set>
#include <iostream>
#include <utility>

// https://raw.githubusercontent.com/agauniyal/rang/master/include/rang.hpp
#include "rang.hpp"

// g++ --std=c++17 c2.cpp -O2 && ./a.out

namespace std
{
    std::string to_string(bool in)
    {
        return in ? "true" : "false";
    }
} // namespace std

class Board
{
public:

    Board(const std::array<std::array<int, 9>, 9>& in)
    :mBoard(in) { }

    void fill(int* in)
    {
        for(size_t row = 0; row < mBoard.size(); row++)
        {
            for(size_t col = 0; col < mBoard.size(); col++)
            {
                *(in + (mBoard.size() * row) + col) = mBoard[row][col];
            }
        }
    }

    void checkPrint(const std::array<std::array<int, 9>, 9>& ref)
    {
        for(size_t row=0; row < mBoard.size(); row++)
        {
            for(size_t col=0; col < mBoard.size(); col++)
            {
                if(mBoard[row][col] == ref[row][col])
                {
                    std::cout << mBoard[row][col] << " ";
                }
                else
                {
                    std::cout << rang::fg::red << mBoard[row][col] << rang::fg::reset << " ";
                }
            }
            std::cout << std::endl;
        }
    }

    void print()
    {
        for(size_t row=0; row < mBoard.size(); row++)
        {
            for(size_t col=0; col < mBoard.size(); col++)
            {
                if(mBoard[row][col] != 0)
                {
                    std::cout << mBoard[row][col] << " ";
                }
                else
                {
                    std::cout << rang::fg::red << mBoard[row][col] << rang::fg::reset << " ";
                }
            }
            std::cout << std::endl;
        }
    }

    bool solve()
    {
        bool result = solveNext(0, 0);
        std::cout << "Solved? " << std::to_string(result) << std::endl;
        return result;
    }

protected:

    bool validRow(int num, size_t row)
    {
        return std::find(mBoard[row].begin(), mBoard[row].end(), num) == mBoard[row].end();
    }

    bool validCol(int num, size_t col)
    {
        // entire col
        for(size_t irow = 0; irow < mBoard.size(); irow++)
        {
            if(mBoard[irow][col] == num)
            {
                return false;
            }
        }
        return true;
    }

    bool validBox(int num, size_t row, size_t col)
    {
        size_t oRow = 3 * (row / 3);
        size_t oCol = 3 * (col / 3);
        // entire box
        for(size_t irow = oRow; irow < oRow+3; irow++)
        {
            if(std::find(mBoard[irow].begin() + oCol, mBoard[irow].begin() + oCol + 3, num) 
                != (mBoard[irow].begin() + oCol + 3))
            {
                return false;
            }
        }
        return true;
    }

    bool isValid(int num, size_t row, size_t col)
    {
        return validRow(num, row) && validCol(num, col) && validBox(num, row, col);
    }

    bool solveNext(size_t row, size_t col)
    {
        if(mBoard[row][col] == 0)
        {
            for(int num = 1; num <=9; num++)
            {
                if(isValid(num, row, col))
                {
                    mBoard[row][col] = num;
                    size_t nextCol = col == 8 ? 0 : col+1;
                    size_t nextRow = col == 8 ? row + 1 : row;
                    if(nextRow == 9 || solveNext(nextRow, nextCol))
                    {
                        return true;
                    }
                    mBoard[row][col] = 0;
                }
            }
        }
        else
        {
            size_t nextCol = col == 8 ? 0 : col + 1;
            size_t nextRow = col == 8 ? row + 1 : row;
            if(nextRow == 9 || solveNext(nextRow, nextCol))
            {
                return true;
            }
        }
        return false;
    }

    std::array<std::array<int, 9>, 9> mBoard;
};

#ifdef BUILD_SHARED
extern "C" {
    bool solve(int *data)
    {
        std::array< std::array<int, 9>, 9> input;
        for(size_t row = 0; row < input.size(); row++)
        {
            for(size_t col = 0; col < input.size(); col++)
            {
                input[row][col] = *(data + (row * input.size()) + col);
            }
        }

        Board board(input);
        board.print();
        bool ret = board.solve();
        board.print();
        board.fill(data);
        return ret;
    }
}
#else
int main()
{
    std::array< std::array<int, 9>, 9> solved {{
        { 4, 3, 5, 2, 6, 9, 7, 8, 1 },
        { 6, 8, 2, 5, 7, 1, 4, 9, 3 },
        { 1, 9, 7, 8, 3, 4, 5, 6, 2 },
        { 8, 2, 6, 1, 9, 5, 3, 4, 7 },
        { 3, 7, 4, 6, 8, 2, 9, 1, 5 },
        { 9, 5, 1, 7, 4, 3, 6, 2, 8 },
        { 5, 1, 9, 3, 2, 6, 8, 7, 4 },
        { 2, 4, 8, 9, 5, 7, 1, 3, 6 },
        { 7, 6, 3, 4, 1, 8, 2, 5, 9 },
    }};

    std::array< std::array<int, 9>, 9> input {{
        { 0, 0, 0, 2, 6, 0, 7, 0, 1 },
        { 6, 8, 0, 0, 7, 0, 0, 9, 0 },
        { 1, 9, 0, 0, 0, 4, 5, 0, 0 },
        { 8, 2, 0, 1, 0, 0, 0, 4, 0 },
        { 0, 0, 4, 6, 0, 2, 9, 0, 0 },
        { 0, 5, 0, 0, 0, 3, 0, 2, 8 },
        { 0, 0, 9, 3, 0, 0, 0, 7, 4 },
        { 0, 4, 0, 0, 5, 0, 0, 3, 6 },
        { 7, 0, 3, 0, 1, 8, 0, 0, 0 },
    }};

    Board board(input);
    board.solve();
    board.print();
}
#endif // BUILD_SHARED