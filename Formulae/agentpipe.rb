class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.0.6"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.6/agentpipe_darwin_arm64.tar.gz"
      sha256 "f8d9adc1445a323f1807ac6f0c02a84df9514322b728605de6714ffefa9b3ddb"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.6/agentpipe_darwin_amd64.tar.gz"
      sha256 "d048099a2b1393e9198bdc7b2db21f2a958de138b9e0ec279e7a7d20d479d505"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.6/agentpipe_linux_arm64.tar.gz"
      sha256 "a8847c2b2c045a4d6753de80def11ce3caff196d587f02b65e6ea685fc784806"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.6/agentpipe_linux_amd64.tar.gz"
      sha256 "370d38eee0e4d95d7fdd9305c1069ab1e790c90d1ba551802af544e441fde2d8"
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
