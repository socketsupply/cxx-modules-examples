module;

#include <iostream>

export module Socket.Boop;

export namespace Boop {
  void burp () {
    std::cout << "BOOP!" << std::endl;
  }
}
