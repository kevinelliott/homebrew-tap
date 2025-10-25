class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.4.8"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.8/agentpipe_darwin_arm64.tar.gz"
      sha256 "e4330dfac243d272825b1bff14c22e386f9da86ff8852530e9076d2648ade2f1"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.8/agentpipe_darwin_amd64.tar.gz"
      sha256 "42b2bacd92505586a63d32ad609f1ea93ff0b631f87052768f976bf04df1b174"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.8/agentpipe_linux_arm64.tar.gz"
      sha256 "9cb8bc1c5857c07e08a48489135e30cf5512fc1a75ae61c66d4655723dbad8d6"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.8/agentpipe_linux_amd64.tar.gz"
      sha256 "67a3405683890d884dc63669a7b0e45168619be8a1e187c679c64147b52a1c3a"
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
