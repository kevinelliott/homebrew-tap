class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.0.12"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.12/agentpipe_darwin_arm64.tar.gz"
      sha256 "b141d35ed3b923a8a3746759b69950ab6cb37d9d78c76b43023b0fd85d554e6e"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.12/agentpipe_darwin_amd64.tar.gz"
      sha256 "42d90926d6a485cb4c4df90f3dbd77754cd3ee88fd613f8a0f12b5d49bd9b9fc"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.12/agentpipe_linux_arm64.tar.gz"
      sha256 "d115e576597883616272b28ef45200d023ec0a532424bafc1be273f3fbe9ae06"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.12/agentpipe_linux_amd64.tar.gz"
      sha256 "70398ca6d62b2c120f00fc2ddbfdc2d23161e446307d5b2c319e9d459e300533"
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
