class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.3.6"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.6/agentpipe_darwin_arm64.tar.gz"
      sha256 "a7462c642c88ec166f2d936796f58c9f012770614bb238edb9ba480de05c9953"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.6/agentpipe_darwin_amd64.tar.gz"
      sha256 "920b11375ad8988fb3434bcd7092f8d9024db077a34ba78dceb9658f0f63b75c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.6/agentpipe_linux_arm64.tar.gz"
      sha256 "26d069a2a14038ba316f74b109de920d10e36fb23b5083b7391e44503d7b384d"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.6/agentpipe_linux_amd64.tar.gz"
      sha256 "83d9a3f29e4d1c5f76aae063c12e9a371eace95a5d5787207ad77c19d0da5abf"
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
