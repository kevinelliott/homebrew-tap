class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.4.5"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.5/agentpipe_darwin_arm64.tar.gz"
      sha256 "3d16c6e5395160a2579de45b2508df9976fe9e065fabcb9d038e2b0059a49aac"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.5/agentpipe_darwin_amd64.tar.gz"
      sha256 "b134244a8e62d22517d2f59ccb29e4a0378ea8b4a787b053edea57bf79eca367"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.5/agentpipe_linux_arm64.tar.gz"
      sha256 "afac22d52f5f5aa6f20f62935f045e285bb8167a7eeb2fb1fa6e49cc950466de"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.5/agentpipe_linux_amd64.tar.gz"
      sha256 "be054bb2975243c0e7a776e6cb383194d32a6e2cc89112b44f1f0e5580d733b5"
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
