#include <vector>
#include <utility>
#include <iostream>
#include <algorithm>

class SquarePoints{
    private:
        std::vector<std::pair<int, int>> sort_points_x(std::vector<std::pair<int, int>>);  
        std::vector<std::pair<int, int>> sort_points_y(std::vector<std::pair<int, int>>);   
    public:
        std::vector<std::pair<int, int>> sort_points(std::vector<std::pair<int, int>>); 
        bool is_square(std::vector<std::pair<int, int>>); 
};

int dot_product(std::pair<int, int> a, std::pair<int, int> b){
    int product = 0;
    product = product + a.first * b.first;
    product = product + a.second * b.second;
    return product;
}

bool point_x_compare(const std::pair<int, int> &a, const std::pair<int, int> &b){
    return a.first < b.first;   
} 

bool point_y_compare(const std::pair<int, int> &a, const std::pair<int, int> &b){
    return a.second < b.second;   
} 

std::vector<std::pair<int, int>> SquarePoints::sort_points_x(std::vector<std::pair<int, int>> points){
    sort(points.begin(), points.end(), point_x_compare); 
    return points; 
} 

std::vector<std::pair<int, int>> SquarePoints::sort_points_y(std::vector<std::pair<int, int>> points){
    sort(points.begin(), points.end(), point_y_compare); 
    return points; 
} 
        
bool SquarePoints::is_square(std::vector<std::pair<int, int>> points){
    std::vector<int> x_s;
    std::vector<int> y_s;
    for(int i = 0; i < points.size() ; i++){
        if(!(std::find(x_s.begin(), x_s.end(), points[i].first) != x_s.end())) {
            x_s.push_back(points[i].first);  
        }
        if(!(std::find(y_s.begin(), y_s.end(), points[i].first) != y_s.end())) {
            y_s.push_back(points[i].first);  
        }
    }
    /* if only 2 each of x and y then we have a level square */
    if(x_s.size() == 2 && y_s.size() == 2)
        return true;
    /* sort points and compute side lengths */
    std::vector<std::pair<int, int>> points_by_x = this->sort_points_x(points);  
    std::vector<std::pair<int, int>> points_by_y = this->sort_points_y(points);  
    std::pair<int, int> s = points_by_y[points_by_y.size() - 1];  
    std::pair<int, int> t = points_by_x[points_by_x.size() - 1];  
    std::pair<int, int> u = points_by_y[0];  
    std::pair<int, int> v = points_by_x[0];  
    if(s.first + u.first != t.first + v.first)
        return false; 
    if(s.second + u.second != t.second + v.second)
        return false; 
    if(s.second - u.second != t.first - v.first)
        return false; 
    /* compute angles */
    std::pair<int, int> dv_st = std::make_pair(s.first - t.first, s.second - t.second);  
    std::pair<int, int> dv_tu = std::make_pair(t.first - u.first, t.second - u.second);  
    std::pair<int, int> dv_uv = std::make_pair(u.first - v.first, u.second - v.second);  
    std::pair<int, int> dv_vs = std::make_pair(v.first - s.first, v.second - s.second);  
    if(dot_product(dv_st, dv_tu) != 0)
        return false;   
    if(dot_product(dv_tu, dv_uv) != 0)
        return false;   
    if(dot_product(dv_uv, dv_vs) != 0)
        return false;   
    return true;  
}  

int main(int argc, char** argv){
    SquarePoints sp; 
    std::vector<std::pair<int, int>> points;
    points.push_back(std::make_pair(10, 20));
    points.push_back(std::make_pair(20, 20));
    points.push_back(std::make_pair(20, 10));
    points.push_back(std::make_pair(10, 10));
    std::cout << sp.is_square(points) << std::endl;    
    points.clear(); 
    points.push_back(std::make_pair(12, 24));
    points.push_back(std::make_pair(16, 10));
    points.push_back(std::make_pair(20, 12));
    points.push_back(std::make_pair(18, 16));
    std::cout << sp.is_square(points) << std::endl;    
    points.clear(); 
    points.push_back(std::make_pair(-3, 1));
    points.push_back(std::make_pair(4, 2));
    points.push_back(std::make_pair(9, -3));
    points.push_back(std::make_pair(2, -4));
    std::cout << sp.is_square(points) << std::endl;    
    points.clear(); 
    points.push_back(std::make_pair(0, 0));
    points.push_back(std::make_pair(2, 1));
    points.push_back(std::make_pair(3, -1));
    points.push_back(std::make_pair(1, -2));
    std::cout << sp.is_square(points) << std::endl;    
}  
