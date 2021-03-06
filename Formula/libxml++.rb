class Libxmlxx < Formula
  desc "C++ wrapper for libxml"
  homepage "https://libxmlplusplus.sourceforge.io/"
  url "https://download.gnome.org/sources/libxml++/2.40/libxml++-2.40.1.tar.xz"
  sha256 "4ad4abdd3258874f61c2e2a41d08e9930677976d303653cd1670d3e9f35463e9"
  revision OS.mac? ? 2: 4

  bottle do
    cellar :any
    sha256 "a4db0095b32a8f25e953f5cab64447d721ad9ff51c9b968a311519a04fe1068c" => :catalina
    sha256 "720d42ff48194360d192e9166697a8e299268ac2722c5c8b599fc2898cbd1def" => :mojave
    sha256 "9f25cf8395b3a06dbfe5d7dc2ddc320e2491211bedbe95ddac53b748eca9a31e" => :high_sierra
    sha256 "074c4e2583789fd71bb88abbb230cee7a55d17bece2ff8630feeb895b0c5fddf" => :sierra
    sha256 "df9a28ad52aa81b36ed20f1e2a860fc4661c486b0cbf779da80771f5494dff42" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "glibmm"

  uses_from_macos "libxml2"

  def install
    ENV.cxx11
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <libxml++/libxml++.h>

      int main(int argc, char *argv[])
      {
         xmlpp::Document document;
         document.set_internal_subset("homebrew", "", "https://www.brew.sh/xml/test.dtd");
         xmlpp::Element *rootnode = document.create_root_node("homebrew");
         return 0;
      }
    EOS
    ENV.libxml2
    gettext = Formula["gettext"]
    glib = Formula["glib"]
    glibmm = Formula["glibmm"]
    libsigcxx = Formula["libsigc++@2"]
    flags = %W[
      -I#{gettext.opt_include}
      -I#{glib.opt_include}/glib-2.0
      -I#{glib.opt_lib}/glib-2.0/include
      -I#{glibmm.opt_include}/glibmm-2.4
      -I#{glibmm.opt_lib}/glibmm-2.4/include
      -I#{include}/libxml++-2.6
      -I#{libsigcxx.opt_include}/sigc++-2.0
      -I#{libsigcxx.opt_lib}/sigc++-2.0/include
      -I#{lib}/libxml++-2.6/include
      -L#{gettext.opt_lib}
      -L#{glib.opt_lib}
      -L#{glibmm.opt_lib}
      -L#{libsigcxx.opt_lib}
      -L#{lib}
      -lglib-2.0
      -lglibmm-2.4
      -lgobject-2.0
      -lsigc-2.0
      -lxml++-2.6
      -lxml2
    ]
    args << "-lintl" if OS.mac?
    system ENV.cxx, "-std=c++11", "test.cpp", "-o", "test", *flags
    system "./test"
  end
end
