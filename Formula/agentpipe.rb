class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.0.11"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.11/agentpipe_darwin_arm64.tar.gz"
      sha256 "b8c6fc066c550c3d7902aba6c4f1809c93e17ee72146b18cef1332928e888beb"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.11/agentpipe_darwin_amd64.tar.gz"
      sha256 "04fd46a15b056a8f585e52b55b2f9c01c16dc363f5215160789cdd0750dd73c4"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.11/agentpipe_linux_arm64.tar.gz"
      sha256 "186180f08495063fefa616a8a85157d461a04bf12e0448fc4e77c603e9410cd2"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.11/agentpipe_linux_amd64.tar.gz"
      sha256 "4e2b92d8880a6a2ee9cd71a57b61cc23444a927ef84cc50fc6a40cd370f3f091"
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
