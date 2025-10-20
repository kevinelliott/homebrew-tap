class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.2.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.0/agentpipe_darwin_arm64.tar.gz"
      sha256 "dbc10fdc83386b4145be2aea402f3b45202e3aec70fca6cb818a5d95b9edab53"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.0/agentpipe_darwin_amd64.tar.gz"
      sha256 "d00799e2c98639ad0a2d299e909531420c1c7b670834f79e15b014192a43453f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.0/agentpipe_linux_arm64.tar.gz"
      sha256 "7317d75912021eac9edc708b7e724fd621d48bf919ea6c8e8d840b66360ca505"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.0/agentpipe_linux_amd64.tar.gz"
      sha256 "d44295de3c9713d1ab0214f87348a1e2d3265967bfa7dff9a3f464d932b66f59"
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
