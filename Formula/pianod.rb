class Pianod < Formula
  desc "Pandora client with multiple control interfaces"
  homepage "https://deviousfish.com/pianod/"
  url "https://deviousfish.com/Downloads/pianod2/Devel/pianod2-301.tar.gz"
  sha256 "d6fa01d786af65fe3b4e6f4f97fa048db6619b9443e23f655d3ea8ab4766caee"

  bottle do
    sha256 "6698a4353e50aed190386ccdf407af24f6b623691ebabdef7f8a0b7dca77b338" => :catalina
    sha256 "c0dfa015b5c5546a2fc4788d716c00520282773a93e7d6669f891f2b1126f587" => :mojave
    sha256 "d7c6ba07d0b46d393c4dc5de718e4dcd3130d6b0f8f2ee5aa5d00efd8ec69e93" => :high_sierra
    sha256 "50b13a02b3aba6fb33fc38f66e1f370ebe60657ed7e5b59d2bc33e65d655a4c3" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "json-c"
  depends_on "libao"
  depends_on "libgcrypt"
  depends_on "ffmpeg" unless OS.mac?

  def install
    ENV["OBJCXXFLAGS"] = "-std=c++11"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/pianod", "-v"
  end
end
