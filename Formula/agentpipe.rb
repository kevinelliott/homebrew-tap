class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.2.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.1/agentpipe_darwin_arm64.tar.gz"
      sha256 "9368b5558500bab4e3354ef590490c1020b30ddf5918cc9bf536f5405ace6f19"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.1/agentpipe_darwin_amd64.tar.gz"
      sha256 "1dcf037ebb549f6cd450d90edc7fa6d50ccdfa42657ebc477c3b4b901021baea"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.1/agentpipe_linux_arm64.tar.gz"
      sha256 "cc747d2c59f540ab1c404e1ae16975fa6101f33ffdafc0cc3e0478946764efbc"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.1/agentpipe_linux_amd64.tar.gz"
      sha256 "2ff1a4944aadff31b1d0ea7426c351def5f7d79a34a8c5612832e9aee4dc4068"
    end
  end

  head "https://github.com/kevinelliott/agentpipe.git", branch: "main"
  depends_on "go" => :build if build.head?

  def install
    if build.head?
      system "go", "build", *std_go_args(ldflags: "-s -w")
    else
      # Extract the correct binary name from the archive
      bin.install Dir["agentpipe_*"].first => "agentpipe"
    end
  end

  test do
    output = shell_output("#{bin}/agentpipe doctor 2>&1")
    assert_match "AgentPipe Doctor", output
  end
end
