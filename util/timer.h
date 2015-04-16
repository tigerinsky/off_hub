#ifndef __TIMER_H_
#define __TIMER_H_

#include <sys/time.h>

namespace tis {

class Timer {
public:
    Timer();
    virtual ~Timer();
public:
    void reset();
    time_t elapse(); 

private:
    struct timeval _start;
    struct timeval _end;
};

}

#endif
