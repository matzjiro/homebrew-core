class Byacc < Formula
  desc "(Arguably) the best yacc variant"
  homepage "https://invisible-island.net/byacc/"
  url "https://invisible-mirror.net/archives/byacc/byacc-20180609.tgz"
  sha256 "5bbb0b3ec3da5981a2488383b652499d6c1e0236b47d8bac5fcdfa12954f749c"

  bottle do
    cellar :any_skip_relocation
    sha256 "106b72206d7ebe96c906e333b16e4779f8491694b0823c2885b5051afac428d0" => :high_sierra
    sha256 "e0badef8e7fb8fd74b8a36f4d5ebff45cb3d28d8d0e92182190321afc28edf4c" => :sierra
    sha256 "36ffa710b56c85d26f679e5dd0e9e50c6fe2c7aea65d2af1848a2c9ef6f4c303" => :el_capitan
    sha256 "13d5f3d94ea59c8473332ec87d76349a0723af04606f3b6106a1a7231d5256e8" => :x86_64_linux
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--program-prefix=b", "--prefix=#{prefix}", "--man=#{man}"
    system "make", "install"
  end

  test do
    system bin/"byacc", "-V"
  end
end
