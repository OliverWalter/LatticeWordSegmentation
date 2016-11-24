// ----------------------------------------------------------------------------
/**
   File: main.cpp
   Copyright (c) <2013> <University of Paderborn>
   Permission is hereby granted, free of charge, to any person
   obtaining a copy of this software and associated documentation
   files (the "Software"), to deal in the Software without restriction,
   including without limitation the rights to use, copy, modify and
   merge the Software, subject to the following conditions:

   1.) The Software is used for non-commercial research and
       education purposes.

   2.) The above copyright notice and this permission notice shall be
       included in all copies or substantial portions of the Software.

   3.) Publication, Distribution, Sublicensing, and/or Selling of
       copies or parts of the Software requires special agreements
       with the University of Paderborn and is in general not permitted.

   4.) Modifications or contributions to the software must be
       published under this license. The University of Paderborn
       is granted the non-exclusive right to publish modifications
       or contributions in future versions of the Software free of charge.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
   OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
   OTHER DEALINGS IN THE SOFTWARE.

   Persons using the Software are encouraged to notify the
   Department of Communications Engineering at the University of Paderborn
   about bugs. Please reference the Software in your publications
   if it was used for them.


   Author: Oliver Walter
*/
// ----------------------------------------------------------------------------
#include <cstdlib>
#include <ctime>
#include "LatticeWordSegmentation.hpp"
#include "FileReader/FileReader.hpp"

int main(int argc, const char **argv)
{
  // initialize random seed
  std::srand(std::time(nullptr));

  // print command line parameters
  for (int IdxArg = 0; IdxArg < argc; IdxArg++) {
    std::cout << argv[IdxArg] << " ";
  }
  std::cout << std::endl;

  // Parse command line arguments
  ParameterParser Parser(argc, argv);

  // Parse Input Files into FST data structures
  FileData InputFileData = FileReader(Parser.GetParameters()).GetInputFileData();
  // initialize the segmenter
  LatticeWordSegmentation Segmenter(Parser.GetParameters(), InputFileData);

  // do the segmentation
  Segmenter.DoWordSegmentation();

  // finished
  std::cout << "Hello world, I'm done!" << std::endl;
  return 0;
}
