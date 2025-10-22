class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.4.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.0/agentpipe_darwin_arm64.tar.gz"
      sha256 "70c90ba847bcad5d161beee3a9d994f02cf5833d4d385a82b7a669d1409c5826"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.0/agentpipe_darwin_amd64.tar.gz"
      sha256 "f22e2d1a60730972e4b97e3355489e45524a13ae2d88f4d0fff539ee82227901"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.0/agentpipe_linux_arm64.tar.gz"
      sha256 "01b21d6eb0ae6712ef2127f00605a9451e45fe42681f13e3decb6d0ca987653f"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.0/agentpipe_linux_amd64.tar.gz"
      sha256 "656e86ad6f8d0a64fcfb420d98e1943f8ba926ac6d76a6a55e6783ff33f01ae3"
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
