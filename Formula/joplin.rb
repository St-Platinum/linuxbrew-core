require "language/node"

class Joplin < Formula
  desc "Note taking and to-do application with synchronisation capabilities"
  homepage "https://joplin.cozic.net/"
  url "https://registry.npmjs.org/joplin/-/joplin-1.0.161.tgz"
  sha256 "e5a277075d672fcb0a6d22e8de4794dc14f2602d460c35a51e69d0ff7ecbfac1"
  revision 1

  bottle do
    sha256 "a104ee7d47df75774ce8e89d2146ab8fe2c23b835b436def294e29846090c495" => :catalina
    sha256 "23d043a12ce27d0afad2c3d9d1e8979f6bb499d3d073be2e39702f411d72b479" => :mojave
    sha256 "5aec579f667bcbcb7d9eec4939cdb657312f236fb99bb8ce8088cf27f7f5de4d" => :high_sierra
    sha256 "9553b09d27f80d519f0ae47f7197cc0c93267ef147156929d734d4c1208a3ae4" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "node"
  depends_on "sqlite"
  depends_on "vips"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec),
                             "--sqlite=#{Formula["sqlite"].opt_prefix}"
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system bin/"joplin", "config", "editor", "subl"
    assert_match "editor = subl", shell_output("#{bin}/joplin config")
  end
end
