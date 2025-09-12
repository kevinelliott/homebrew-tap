class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.0.9"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.9/agentpipe_darwin_arm64.tar.gz"
      sha256 "d0fe109785557d39d7744c41bc94acb07d2006556b4ebdab1b8dcb69d6229783"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.9/agentpipe_darwin_amd64.tar.gz"
      sha256 "8051297b8c5a7fb3af9b3fa8096a365319bd20a4ef6855d648b8ed6af5314227"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.9/agentpipe_linux_arm64.tar.gz"
      sha256 "679dc61237c4bbc72b934e6926d9cf42b899ca503cfa1051dc1120b57ec52331"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.9/agentpipe_linux_amd64.tar.gz"
      sha256 "03bfc90f369a4969e4450f6cd4cf65620697a7e356b17e85bf3ce74d2654b9fd"
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
