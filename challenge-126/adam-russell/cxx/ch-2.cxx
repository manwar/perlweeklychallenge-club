#include <cstdlib>
#include <iostream>

/*
 * You are given a rectangle with points
 * marked with either x or *. Consider
 * the x as a land mine. Write a script
 * to print a rectangle with numbers
 * and x as in the Minesweeper game.
*/   

class MinesweeperGame{
    private:
        char** initialize_grid(int, int);   
    public:
        void make_print_grid(int, int);   
};     

char** MinesweeperGame::initialize_grid(int m, int n){
    char** grid = new char*[m];  
    for(int i = 0; i < m; i++){
        grid[i] = new char[n]; 
        for(int j = 0; j < n; j++){
            grid[i][j] = '*'; 
            if(rand() / double(RAND_MAX) < 1 / 3.0)
                grid[i][j] = 'x'; 
        } 
    } 
    return grid;
}

void MinesweeperGame::make_print_grid(int m, int n){
    char** grid = initialize_grid(m, n); 
    std::cout << "Input:" << std::endl; 
    for(int i = 0; i < m; i++){
        std::cout << "\t";
        for(int j = 0; j < n; j++){
            std::cout << grid[i][j] << " "; 
        } 
        std::cout << std::endl; 
    } 
    for(int i = 0; i < m; i++){
        for(int j = 0; j < n; j++){
            if(grid[i][j] == '*'){
                int mine_count = 0;
                if(i >= 1 && j >= 1 && grid[i - 1][j - 1] == 'x')
                    mine_count++; 
                if(i >= 1 && grid[i - 1][j] == 'x')
                    mine_count++; 
                if(i >= 1 && j < n - 1 && grid[i - 1][j + 1] == 'x')
                    mine_count++; 
                if(j >= 1 && grid[i][j - 1] == 'x')
                    mine_count++; 
                if(j < n - 1 && grid[i][j + 1] == 'x')
                    mine_count++; 
                if(i < m - 1 && j >= 1 && grid[i + 1][j - 1] == 'x')
                    mine_count++; 
                if(i < m - 1 && grid[i + 1][j] == 'x')
                    mine_count++; 
                if(i < m - 1 && j < n - 1 && grid[i + 1][j + 1] == 'x')
                    mine_count++; 
                char temp[1];
                sprintf(temp, "%d", mine_count); 
                grid[i][j] = *temp;
            } 
        } 
    } 
    std::cout << "Output:" << std::endl; 
    for(int i = 0; i < m; i++){
        std::cout << "\t";
        for(int j = 0; j < n; j++){
            std::cout << grid[i][j] << " "; 
        } 
        std::cout << std::endl; 
    } 
}

int main(int argc, char** argv){
    srand(time(NULL)); 
    int m = atoi(argv[1]); 
    int n = atoi(argv[2]); 
    MinesweeperGame mn;
    mn.make_print_grid(m, n);
}

