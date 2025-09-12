class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.0.8"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.8/agentpipe_darwin_arm64.tar.gz"
      sha256 "bc91e1dad456508291b9293e4c2f9eb5fd6b549f934d88c77135ab6ee76a9435"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.8/agentpipe_darwin_amd64.tar.gz"
      sha256 "5d2bc633b4f06eabeeea3c05fd0823e9e6f0fc9dd2a595add1b7252f2606771c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.8/agentpipe_linux_arm64.tar.gz"
      sha256 "ba78f0be1a3b47be4091c685a113a9bca5a455e5952747e3bafebb2893bc0e6c"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.8/agentpipe_linux_amd64.tar.gz"
      sha256 "b8bf2eff6b3534ac10b32403d815b2e6704c74f455e55cc66a7a05d1abd289c9"
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
