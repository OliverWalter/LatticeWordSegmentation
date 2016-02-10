// ----------------------------------------------------------------------------
/**
   File: LatticeWordSegmentationTimer.hpp

   Status:         Version 1.0
   Language: C++

   License: UPB licence

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

   E-Mail: walter@nt.uni-paderborn.de

   Description: a timing class for the word segmenter (contains sevral timers)

   Limitations: -

   Change History:
   Date         Author       Description
   2014         Walter       Initial
*/
// ----------------------------------------------------------------------------
#ifndef _LMWSTIMER_HPP_
#define _LMWSTIMER_HPP_

#include <chrono>
#include <vector>

/* class to hold some timing information */
class LatticeWordSegmentationTimer {
public:
  /* class for a simple timer */
  class SimpleTimer {
    std::chrono::high_resolution_clock::time_point Start; // s
    std::chrono::duration<double> Duration;               // duration spend for the timer

  public:
    SimpleTimer();                      // initialize the simple timeing objects (set duration to zero)
    void SetStart();                    // set starting point of timer
    void AddTimeSinceStartToDuration(); // add elapsed time from starting pint to duration
    double GetDuration() const;         // return duration
  };

  /* timing objects publicly available */
  SimpleTimer tLexFst;                  // time for building lexicon fst
  SimpleTimer tRemove;                  // time for removing samples from lexicon, lexfst and language model
  SimpleTimer tSample;                  // time for sampling a new segmentation
  SimpleTimer tParseAndAdd;             // time for parsing and adding
  SimpleTimer tHypSample;               // time for resampling of hyper parameters
  SimpleTimer tCalcWER;                 // time for calculating the word error rate
  SimpleTimer tCalcPerplexity;          // time for calculating the perplexity
  SimpleTimer tCalcPER;
  std::vector<std::vector<SimpleTimer> > tInSamples; // times for the different tasks in the sampling threads

  /* constructor */
  LatticeWordSegmentationTimer(int MaxNumThreads, int NumTimersPerThread); // construction for a given numer of threads and number of subtimers per thread

  /* interface */
  void PrintTimingStatistics() const; // print the statistics
};

#endif