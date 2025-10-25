class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.4.6"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.6/agentpipe_darwin_arm64.tar.gz"
      sha256 "837df59a67e777c63ac51047d75f50e19e7938d204c26a9348b9156ebd725cde"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.6/agentpipe_darwin_amd64.tar.gz"
      sha256 "2d256cfd136f44b7e705bd3b610ce5fd03a169abee20e0e5ade970125f4b9727"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.6/agentpipe_linux_arm64.tar.gz"
      sha256 "1cf9fdc71f7ab0e9af047aab431aa986f22296b264a5992cc5025b365211aaca"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.6/agentpipe_linux_amd64.tar.gz"
      sha256 "ee34067ca0c29f76f456960ba2ec82dab537ea32dc652a723c3934e0c592a615"
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
