class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.3.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.1/agentpipe_darwin_arm64.tar.gz"
      sha256 "2ae57d41248f5fb6374183bcb126ad2ca76111ce75d7a68bcb3f2a5a2637fd25"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.1/agentpipe_darwin_amd64.tar.gz"
      sha256 "91a778a4f7a086e5816cb68ef12007064e4aa746b1b140160b728734721a9439"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.1/agentpipe_linux_arm64.tar.gz"
      sha256 "81343193272285739f025a78c4d4a3ac7447130d15fecff52bb510450201e2a6"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.1/agentpipe_linux_amd64.tar.gz"
      sha256 "c522a7b5c7ffd9e1d05117d1852b6abdb1bc7778f97f47630e66da3e4ba0e1b7"
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
