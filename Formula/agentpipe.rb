class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.2.3"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.3/agentpipe_darwin_arm64.tar.gz"
      sha256 "2f4cb6ff3919eda38e24a433c1e508c23b3017213aa47061a861cf5d64c5a939"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.3/agentpipe_darwin_amd64.tar.gz"
      sha256 "aad21d3100b645c7be8f31c686eea62fe52ddd15cb6d712a2716b0cc7afd4b5f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.3/agentpipe_linux_arm64.tar.gz"
      sha256 "de58a1d5b155e847141934cfe52eaf6a9207f542f81c624bd3c234a1aeeb2812"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.3/agentpipe_linux_amd64.tar.gz"
      sha256 "1730e535068a8832d08bea059a2fe618fd0204d9077c7beeb2005f1994397afb"
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
