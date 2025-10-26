class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.5.2"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.2/agentpipe_darwin_arm64.tar.gz"
      sha256 "304b14c90e49ff4db1d6497d837cd3e688606f52cc6a47a57a50cb50850376fa"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.2/agentpipe_darwin_amd64.tar.gz"
      sha256 "a5b366c3502af9b7dc01f166c84920b0f9608b5c71c2407d2145282f26ef7712"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.2/agentpipe_linux_arm64.tar.gz"
      sha256 "6109d9df6b303f77013584709f405d30cc2e78db60a087f556576951b37464dd"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.2/agentpipe_linux_amd64.tar.gz"
      sha256 "722ff03fb1accd469c4f42e1880ff00205dce5ace6ffe5f5af877f4d2ff98f1e"
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
