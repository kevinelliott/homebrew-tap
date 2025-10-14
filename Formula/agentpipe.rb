class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.0.15"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.15/agentpipe_darwin_arm64.tar.gz"
      sha256 "6be0a37a07f6a6a5b209c3bef15b4ee45786094436fee4d30550febd457d4af8"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.15/agentpipe_darwin_amd64.tar.gz"
      sha256 "9a61be1e6c63bdcde97c8c45c53cc003ed7bd607dace60d2df49f44433338220"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.15/agentpipe_linux_arm64.tar.gz"
      sha256 "ae0a9f6ffa65a19b02336aab832d14c01e973cccd7d9d50873739e1f1659d453"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.15/agentpipe_linux_amd64.tar.gz"
      sha256 "e0e41e7f5e2274ddbbe8ada8d65fa3d38384ee441b260ac8e4defc91de2f735d"
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
