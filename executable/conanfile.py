from conans import ConanFile, CMake


class ExecutableConan(ConanFile):
    name = "executable"
    version = "1.0"
    description = "Executable"
    url = "https://github.com/lbakman/conan_targets.gitk"
    exports_sources = "cmake/*", "src/*", "include/*", "CMakeLists.txt"
    generators = "cmake", "txt"
    settings = "os", "arch", "compiler", "build_type"
    license = ""
    requires = "library_b/1.0@lb/testing"

    def build(self):
        cmake = CMake(self)
        # Using build dir does not seem to work correctly when doing in-source conan files.
        cmake.configure(source_dir=".", build_dir=".")
        cmake.build()

    def package(self):
        self.copy(pattern="*.exe", dst="bin", src="bin", keep_path=False)

    def package_info(self):
        pass