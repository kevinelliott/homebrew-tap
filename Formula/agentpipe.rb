class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.5.4"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.4/agentpipe_darwin_arm64.tar.gz"
      sha256 "819390be31cf3e7d1f48b398c33e1698e4d0439c73c8e0367ee749faac942b26"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.4/agentpipe_darwin_amd64.tar.gz"
      sha256 "975453b7f4aa57be6c10750619b31f6283283690a7f17b4719f46075a66e73e3"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.4/agentpipe_linux_arm64.tar.gz"
      sha256 "8f0e192411c702e20cb380d8f6f5cf923ecb48dc8e85466b6cc8e1e0e84048ed"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.4/agentpipe_linux_amd64.tar.gz"
      sha256 "2dd862802b3c0b5ca99d155de609acae83fedcb8381fc5ca3e907f809abfdeb4"
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
