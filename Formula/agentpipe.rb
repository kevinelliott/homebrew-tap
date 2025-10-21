class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.2.4"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.4/agentpipe_darwin_arm64.tar.gz"
      sha256 "59385b1165e528d821b89723785a3a9056620c17860760f98ccf5cf7379d3ceb"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.4/agentpipe_darwin_amd64.tar.gz"
      sha256 "ef413aef5e3fcbc6852113ece1f5fe7c4f83cda109eaa8c88a57522d56b0f5d9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.4/agentpipe_linux_arm64.tar.gz"
      sha256 "60ce4f434ead6e89b8dd099d9a71fae500ec4df4a51c4f9af3acd3957921037d"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.4/agentpipe_linux_amd64.tar.gz"
      sha256 "281bb9bb5c367a63e9a6c82903d60735a9c0b026c31e536b843f93acb32197eb"
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
