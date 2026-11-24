class ClsEedi < Formula
  desc "Inspect CLS.EEDI grid controls and device state"
  homepage "https://crates.io/crates/cls-eedi"
  url "https://static.crates.io/crates/cls-eedi/cls-eedi-0.1.0.crate"
  version "0.1.0"
  sha256 "28b44c85a648da6ac0a754b239f141e2982dd618278dbb1641930b98e75afd8e"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--no-track", "--locked", "--path", ".", "--root", prefix, "--bin", "cls-eedi"
  end

  test do
    assert_equal "cls-eedi #{version}", shell_output("#{bin}/cls-eedi --version").strip
    message = '{"type":"de.keo-connectivity.clseedi.read","id":"probe","source":"brew","specversion":"1.0","data":{"protocol":"1.2.0","parameters":["limits"]}}'
    assert_match "valid read (CLS.EEDI 1.2.0)", pipe_output("#{bin}/cls-eedi check", message, 0)
  end
end
