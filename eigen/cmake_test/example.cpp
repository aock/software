#include <iostream>
#include <Eigen/Dense>
using Eigen::MatrixXd;

int main(int argc, char** argv)
{
  MatrixXd m(2,2);
  m(0,0) = 3;
  m(1,0) = 2.5;
  m(0,1) = -1;
  m(1,1) = m(1,0) + m(0,1);
  
  std::cout << EIGEN_WORLD_VERSION << "." << EIGEN_MAJOR_VERSION << "." << EIGEN_MINOR_VERSION << std::endl;
  return 0;
}