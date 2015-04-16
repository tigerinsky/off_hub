#include "timer.h"

namespace tis {

Timer::Timer() {
    gettimeofday(&_start, 0);
}

Timer::~Timer() {
}

void Timer::reset() {
    gettimeofday(&_start, 0);
}

time_t Timer::elapse() {
    gettimeofday(&_end, 0);
    time_t diff = (_end.tv_sec-_start.tv_sec) * 1000000
            + _end.tv_usec - _start.tv_usec;

    return diff;
}

}
