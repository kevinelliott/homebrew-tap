class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.3.4"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.4/agentpipe_darwin_arm64.tar.gz"
      sha256 "3ed591d0e77e765bc8a2153cb20f5609491b3681fa79a25c7f3a969a0751f964"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.4/agentpipe_darwin_amd64.tar.gz"
      sha256 "7191c3f36d58080a46e1fe0c1110319a4b0df978c8aebfa23f0b1b1cefe94cdd"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.4/agentpipe_linux_arm64.tar.gz"
      sha256 "d3bf45d8c3651316294300b0f60957c847245a61df5d82f1518c6f5b4c35bc53"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.4/agentpipe_linux_amd64.tar.gz"
      sha256 "4a2ee043cb6912f9882541861e75f4d97f961745510b1c7a990cb5061f0a451b"
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
