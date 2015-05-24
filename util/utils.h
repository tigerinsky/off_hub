#ifndef __UTILS_H_
#define __UTILS_H_

#include <string>
#include <iostream>
#include <sstream>

namespace tis {

std::string code_convert(std::string& in_str,
                    char const* from_type,
                    char const* to_type);

template<typename FromType, typename ToType>
ToType type_convert(const FromType& from) {
    std::stringstream str_stream;
    ToType to;

    str_stream << from;
    str_stream >> to;

    return to;
}

}

#endif // __UTILS_H_
