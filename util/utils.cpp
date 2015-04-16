
#include <iconv.h>
#include <string.h>

#include "glog/logging.h"

#include "utils.h"

namespace tis {
std::string code_convert(std::string& in_str,
                    char const* from_type,
                    char const* to_type) {
    // TODO: to conf
    char out_chr[1024 * 1024];
    char* in_chr = const_cast<char*>(in_str.c_str());
    char** p_in_chr = &in_chr;
    char* out_chr_p = out_chr;
    char** p_out_chr = &out_chr_p;
    size_t in_len = in_str.size();
    size_t out_len = 1024 * 1024 - 1;
    size_t* p_in_len = &in_len;
    size_t* p_out_len = &out_len;
    size_t ret_size = 0;
    iconv_t conv_code;

    memset(out_chr, 0, sizeof(char) * 1024 * 1024);
    conv_code = iconv_open(to_type, from_type);
    if (!conv_code) {
        return false;
    }

    ret_size = iconv(conv_code, p_in_chr, p_in_len, p_out_chr, p_out_len);
    if ((size_t)-1 == ret_size) {
        LOG(ERROR) << "util code convert: iconv error.";
        iconv_close(conv_code);
        return std::string();
    }
    iconv_close(conv_code);

    return std::string(out_chr);
}

}
