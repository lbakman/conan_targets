/****************************************************************
*                                                               *
* Copyright (C) 2017 Saab Danmark A/S                           *
*                                                               *
* The copyright to the computer program(s) and/or documentation *
* herein is the property of Saab Danmark A/S. The program(s)    *
* and/or documentation may be used and/or copied only with the  *
* written permission of Saab Danmark A/S, or in accordance with *
* the terms and conditions stipulated in the agreement/contract *
* under which the program(s) and/or documentation have been     *
* supplied.                                                     *
*                                                               *
*****************************************************************
*                                                               *
* Information classifications: Not export controlled            *
*                              Company restricted               *
*                              Defence unclassified             *
*                                                               *
****************************************************************/
#include "Executable.h"
#if defined(DIRECT_DEPENDECY_ON_A)
#include "LibraryA/ClassA.h"
#endif //  defined(DIRECT_DEPENDECY_ON_A)
#include "LibraryB/ClassB.h"

#include <iostream>

Executable::Executable() {

}

Executable::~Executable() {

}

int Executable::run() {
#if defined(DIRECT_DEPENDECY_ON_A)
    LibraryA::ClassA a;
    std::cout << "A: " << a.fullName() << std::endl;
#endif //  defined(DIRECT_DEPENDECY_ON_A)
    LibraryB::ClassB b;
    std::cout << "B: " << b.fullName() << std::endl;
    return 0;
}

#if defined(_WIN32) && defined(UNICODE)
int wmain(int argc, wchar_t** argv)
#else
int main(int argc, char** argv)
#endif
{
    Executable exec;
    return exec.run();
}
