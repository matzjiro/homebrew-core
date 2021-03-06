class AngleGrinder < Formula
  desc "Slice and dice log files on the command-line"
  homepage "https://github.com/rcoh/angle-grinder"
  url "https://github.com/rcoh/angle-grinder/archive/v0.7.5.tar.gz"
  sha256 "9d99ae18666f0e63fe7aef9ad4eed18440d4f395329ef616758d087b9b1f758b"

  bottle do
    sha256 "8f2f356c465074a10d7ced0e41da052df20b7443cdcb5703f0c014f6d7c78223" => :high_sierra
    sha256 "635c1e2d84f5a176150628cc281550d0b0aaf7fe4d2dbc5a79752847e83ec0f8" => :sierra
    sha256 "0291d2073ce16b5f7edb8c6b1ae4b4722f9770e43ca1bac247d76da2adfff504" => :el_capitan
    sha256 "6f06a8c93533ad298fd54fd701890e18cf0a2f599486d683bbb56e51d94989ac" => :x86_64_linux
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--root", prefix
  end

  test do
    (testpath/"logs.txt").write("{\"key\": 5}")
    output = shell_output("#{bin}/agrind --file logs.txt '* | json'")
    assert_match "[key=5]", output
  end
end
