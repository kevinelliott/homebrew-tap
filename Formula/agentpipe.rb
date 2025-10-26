class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.5.5"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.5/agentpipe_darwin_arm64.tar.gz"
      sha256 "4fab0982a6c071a46dd8b8eab1c8ffaf73c5f243467e2ae30e9473ba396b2381"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.5/agentpipe_darwin_amd64.tar.gz"
      sha256 "f4e344991e812c07e2d4a5ae69387db7b813e0dd0701cba202a3587e61c44312"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.5/agentpipe_linux_arm64.tar.gz"
      sha256 "ce6cfe58f763d37a0bc0cc1cee835830a14227efa3a779248d09df57466116c4"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.5/agentpipe_linux_amd64.tar.gz"
      sha256 "3fa7088cf41444a0f86d2d158825b411593bc33d7e199fcd1bc588387393ed8e"
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
