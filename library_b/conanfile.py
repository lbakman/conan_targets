from conans import ConanFile, CMake


class LibraryBConan(ConanFile):
    name = "library_b"
    version = "1.0"
    description = "Library B"
    url = "https://github.com/lbakman/conan_targets.gitk"
    exports_sources = "cmake/*", "src/*", "include/*", "CMakeLists.txt"
    generators = "cmake", "txt"
    settings = "os", "arch", "compiler", "build_type"
    license = ""
    requires = "library_a/1.0@lb/testing"

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

    def package_info(self):
        self.cpp_info.libs = ["library_b"]

        if self.settings.build_type == "Debug":
            self.cpp_info.libs = ["%s_d" % lib for lib in self.cpp_info.libs]
