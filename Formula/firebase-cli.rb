require "language/node"

class FirebaseCli < Formula
  desc "Firebase command-line tools"
  homepage "https://firebase.google.com/docs/cli/"
  url "https://registry.npmjs.org/firebase-tools/-/firebase-tools-4.0.3.tgz"
  sha256 "bd6f13720f285ccb0ba409117867ed950d6a6c79a5f2837c9caa6024f3bd4232"
  head "https://github.com/firebase/firebase-tools.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "144e1a0857c0122a56bc0a3b99f4b3a88982f79e5b8717945b9404bf7dcda25c" => :high_sierra
    sha256 "e014e74bec2ce7b9a324a7bc8f237f2e1c166bed95d3233bc20482ff3e8b70c6" => :sierra
    sha256 "dae6b668b1d5a49cd69d8ad37a458a1299347675fe9db912ceeee866e9a8804b" => :el_capitan
    sha256 "e707f4844760883ac562207d1a78eff9f0672f60ac3558c885a876f3ac655187" => :x86_64_linux
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    # The following test requires /usr/bin/expect.
    return unless OS.mac?
    (testpath/"test.exp").write <<~EOS
      spawn #{bin}/firebase login:ci --no-localhost
      expect "Paste"
    EOS
    assert_match "authorization code", shell_output("expect -f test.exp")
  end
end
