class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.0.14"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.14/agentpipe_darwin_arm64.tar.gz"
      sha256 "504dd03db41032b0886d4c60e8b3790730dfa52cd6d0f9b29183fbab4f868bc7"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.14/agentpipe_darwin_amd64.tar.gz"
      sha256 "e26005678a10054d6a7cf7829866742e49162d29b278eba78ea1c4e2b16576ff"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.14/agentpipe_linux_arm64.tar.gz"
      sha256 "b2b332f8166b43991e7836cd1f99b1cc336def3ba740cecd2f54d4ec7fe0ad92"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.14/agentpipe_linux_amd64.tar.gz"
      sha256 "66a79060982ed380315ba7e7d5ec9cf213c649dbc7217d30f169860613d5f0cf"
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
