from conans import ConanFile, CMake


class LibraryAConan(ConanFile):
    name = "library_a"
    version = "1.0"
    description = "Library A"
    url = "https://github.com/lbakman/conan_targets.gitk"
    exports_sources = "cmake/*", "src/*", "include/*", "CMakeLists.txt"
    generators = "cmake", "txt"
    settings = "os", "arch", "compiler", "build_type"
    license = ""

    def build(self):
        cmake = CMake(self)
        # Using build dir does not seem to work correctly when doing in-source conan files.
        cmake.configure(source_dir=".", build_dir=".")
        cmake.build()

    def package(self):
        self.copy(pattern="*.h", dst="include", src="include", keep_path=True)
        self.copy(pattern="*.lib", dst="lib", src="lib", keep_path=False)
        self.copy(pattern="*.a", dst="lib", src="lib", keep_path=False)
        self.copy(pattern="*.dll", dst="lib", src="bin", keep_path=False)
        self.copy(pattern="*.exe", dst="bin", src="bin", keep_path=False)
        self.copy(pattern="*.jar", dst="lib", src="lib", keep_path=False)
        self.copy(pattern="*.jar", dst="lib", src="bin", keep_path=False)

    def package_info(self):
        self.cpp_info.libs = ["library_a"]

        if self.settings.build_type == "Debug":
            self.cpp_info.libs = ["%s_d" % lib for lib in self.cpp_info.libs]
