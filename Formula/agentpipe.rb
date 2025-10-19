class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.1.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.1/agentpipe_darwin_arm64.tar.gz"
      sha256 "94e52e7d4ebc482d39c02ee1c4c2f5d0df87566dc7ac5896bc4c8305ee001fb3"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.1/agentpipe_darwin_amd64.tar.gz"
      sha256 "aee288aa1559ecb09760e5a8e4e170b2ca019d216fb3f6ed5269a89b5df16f03"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.1/agentpipe_linux_arm64.tar.gz"
      sha256 "634a282ba5db3c53db28a8b2ba2694b3ac176f20cf0cfa100e3fb1e76e975f3e"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.1/agentpipe_linux_amd64.tar.gz"
      sha256 "1274be88d5fcd698aaccb8827eb77f2aa6699ab91dd607a7eafd6e801e489b58"
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
