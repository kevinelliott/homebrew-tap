class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.4.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.1/agentpipe_darwin_arm64.tar.gz"
      sha256 "1ce78227e78b8f6c5d707a8431bdc207685316164b9f4689dfd9abbe1d2e539c"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.1/agentpipe_darwin_amd64.tar.gz"
      sha256 "be45fd793cbeae04dbdc12f75a4ff99ac0b14b1914ec3d8339ff58896b44e74b"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.1/agentpipe_linux_arm64.tar.gz"
      sha256 "b218f67ab3706e2a6e6aa1643073b5a6da497257cc67581067194ce189975123"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.1/agentpipe_linux_amd64.tar.gz"
      sha256 "9b8641ab0908cf1b3455abfa5e932be0e47e2672afa28ef57ba40c1390f74749"
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
