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
#ifndef CONAN_EXPORTS_PROJECT_CLASSB_H
#define CONAN_EXPORTS_PROJECT_CLASSB_H

#include <string>

namespace LibraryB {

class ClassB {
public:
    ClassB();
    ~ClassB();

    std::string name() const;
    std::string fullName() const;
};

}


#endif //CONAN_EXPORTS_PROJECT_CLASSB_H
