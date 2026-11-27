class OpcuaKit < Formula
  desc "Inspect OPC UA servers and verify signal contracts"
  homepage "https://crates.io/crates/opcua-kit"
  url "https://static.crates.io/crates/opcua-kit/opcua-kit-0.1.0.crate"
  version "0.1.0"
  sha256 "7a9b9f61683097660d46074ae3cc63a472b53339eceeadc96bd6f3bcb7c10992"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(features: ["cli", "cems"])
  end

  test do
    assert_equal "opcua-kit #{version}", shell_output("#{bin}/opcua-kit --version").strip
    assert_match "EngineeringUnits", shell_output("#{bin}/opcua-kit demo --scenario units", 2)
    system bin/"opcua-kit", "meter", "example", "--export", "shift"
    assert_path_exists testpath/"shift/contract.json"
  end
end
