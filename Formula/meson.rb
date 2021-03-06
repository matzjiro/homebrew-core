class Meson < Formula
  desc "Fast and user friendly build system"
  homepage "https://mesonbuild.com/"
  url "https://github.com/mesonbuild/meson/releases/download/0.47.1/meson-0.47.1.tar.gz"
  sha256 "d673de79f7bab064190a5ea06140eaa8415efb386d0121ba549f6d66c555ada6"
  head "https://github.com/mesonbuild/meson.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9bdf153903e78a320b5b22805f9f920e7b407966f6b045f241cae54236ccdbec" => :high_sierra
    sha256 "9bdf153903e78a320b5b22805f9f920e7b407966f6b045f241cae54236ccdbec" => :sierra
    sha256 "9bdf153903e78a320b5b22805f9f920e7b407966f6b045f241cae54236ccdbec" => :el_capitan
    sha256 "057a41b4933e71043611b0e1c407a2aab3e8015e91b3cb7794ac748fbbc9bcac" => :x86_64_linux
  end

  depends_on "python"
  depends_on "ninja"

  def install
    version = Language::Python.major_minor_version("python3")
    ENV["PYTHONPATH"] = lib/"python#{version}/site-packages"

    system "python3", *Language::Python.setup_install_args(prefix)

    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    (testpath/"helloworld.c").write <<~EOS
      main() {
        puts("hi");
        return 0;
      }
    EOS
    (testpath/"meson.build").write <<~EOS
      project('hello', 'c')
      executable('hello', 'helloworld.c')
    EOS

    mkdir testpath/"build" do
      system "#{bin}/meson", ".."
      assert_predicate testpath/"build/build.ninja", :exist?
    end
  end
end
