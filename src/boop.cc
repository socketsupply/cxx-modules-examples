module;

#include <iostream>

export module Socket.Boop;

import Socket.Quxx;
// import <iostream>;

export namespace Boop {
  void burp () {
    std::cout << Quxx::burp() << std::endl;
  }
}
