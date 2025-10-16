class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.0.16"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.16/agentpipe_darwin_arm64.tar.gz"
      sha256 "bf887180ac89108d579b36e67cf4850b4bccaa94768087bf0d2113b7b8feb3d1"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.16/agentpipe_darwin_amd64.tar.gz"
      sha256 "ed8b246c2e2abf6b2e4f6b863226264462f1dc763ad2c45719424613ee823e72"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.16/agentpipe_linux_arm64.tar.gz"
      sha256 "3f2d2349583b736b07c2fc0bda1c60b5929d3df0ca0bd6d66a04d789bb015dd6"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.16/agentpipe_linux_amd64.tar.gz"
      sha256 "b683c583b3339ec7985faea4f79d436dc2f2580f61d03c14f643584fba67e79a"
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
