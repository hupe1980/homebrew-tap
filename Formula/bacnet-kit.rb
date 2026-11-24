class BacnetKit < Formula
  desc "Commission BACnet devices and inspect MS/TP frames"
  homepage "https://crates.io/crates/bacnet-kit"
  url "https://static.crates.io/crates/bacnet-kit/bacnet-kit-0.1.0.crate"
  version "0.1.0"
  sha256 "4c1e373638b5f4239985d2e2a00930765d9ec9282ad9ebfaa906e5e1dbaf0d41"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(features: ["sc-node"])
  end

  test do
    assert_equal "bacnet-kit #{version}", shell_output("#{bin}/bacnet-kit --version").strip
    assert_match "TARGET-VMAC", shell_output("#{bin}/bacnet-kit sc-read --help")
    assert_match "TOKEN (0)", shell_output("#{bin}/bacnet-kit mstp-frame 55ff000102000040")
  end
end
