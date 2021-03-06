class LadspaSdk < Formula
  desc "Linux Audio Developer's Simple Plugin"
  homepage "https://ladspa.org"
  url "https://www.ladspa.org/download/ladspa_sdk_1.15.tgz"
  sha256 "4229959b09d20c88c8c86f4aa76427843011705df22d9c28b38359fd1829fded"

  bottle do
    sha256 "87235984ac866b2b579c6b944b767cc7bd2778ae963fae262f2d98b72528326f" => :x86_64_linux
  end

  depends_on :linux

  def install
    chdir "src" do
      inreplace "Makefile", "INSTALL_PLUGINS_DIR	=	/usr/lib/ladspa/", "INSTALL_PLUGINS_DIR	=	#{lib}"
      inreplace "Makefile", "INSTALL_INCLUDE_DIR	=	/usr/include/", "INSTALL_INCLUDE_DIR	=	#{include}"
      inreplace "Makefile", "INSTALL_BINARY_DIR	=	/usr/bin/", "INSTALL_BINARY_DIR	=	#{bin}"
      system "make", "install"
    end
  end

  test do
    assert_match "Mono Amplifier", shell_output("#{bin}/listplugins")
  end
end
