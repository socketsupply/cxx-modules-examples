module;

#include <iostream>

export module Socket.Beep;

export namespace Beep {
  void inline burp () {
    std::cout << "BEEP!" << std::endl;
  }
}
