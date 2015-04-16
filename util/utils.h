#ifndef __UTILS_H_
#define __UTILS_H_

#include <string>

namespace tis {

std::string code_convert(std::string& in_str,
                    char const* from_type,
                    char const* to_type);

}

#endif // __UTILS_H_
