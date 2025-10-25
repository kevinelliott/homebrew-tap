class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.4.9"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.9/agentpipe_darwin_arm64.tar.gz"
      sha256 "9864b259e167abc60398a51c3c2c5d46238dd5c2ebb9760c58fd73c87671fef5"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.9/agentpipe_darwin_amd64.tar.gz"
      sha256 "de81756a0f72447a087a48bf4d8cc30a4f3d42efce73062283ad829dc3633c2b"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.9/agentpipe_linux_arm64.tar.gz"
      sha256 "32fead137f50b225cdefcff27d9a6260141b0d506c27b7e1704460c33d7d6042"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.9/agentpipe_linux_amd64.tar.gz"
      sha256 "c9647fe4d5d1adb826510dcad45003898d6da7a5969b2da1fc655bd5cf1e7625"
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
