class Sonarqube < Formula
  desc "Manage code quality"
  homepage "https://www.sonarqube.org/"
  url "https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-7.2.1.zip"
  sha256 "1cf91a39d9161f0dca00e5ed50f9c11ff055634c6f7efa2aa0ca50066f01d868"

  bottle :unneeded

  depends_on :java => "1.8+"

  conflicts_with "sonarqube-lts", :because => "both install the same binaries"

  def install
    # Delete native bin directories for other systems
    rm_rf "bin/linux-x86-32" unless OS.linux? && !MacOS.prefer_64_bit?
    rm_rf "bin/linux-x86-64" unless OS.linux? && MacOS.prefer_64_bit?
    rm_rf "bin/macosx-universal-32" unless OS.mac? && !MacOS.prefer_64_bit?
    rm_rf "bin/macosx-universal-64" unless OS.mac? && MacOS.prefer_64_bit?
    rm_rf Dir["bin/windows-*"]

    libexec.install Dir["*"]

    bin.install_symlink Dir[libexec/"bin/*/sonar.sh"].first => "sonar"
  end

  plist_options :manual => "sonar console"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
        <string>#{opt_bin}/sonar</string>
        <string>start</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
    </dict>
    </plist>
  EOS
  end

  test do
    assert_match "SonarQube", shell_output("#{bin}/sonar status", 1)
  end
end
