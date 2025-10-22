class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.3.5"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.5/agentpipe_darwin_arm64.tar.gz"
      sha256 "a54f9ca34fe4bf53722a31030533eb9e7169389dfa4ad5d35c2548eed7c2c7b9"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.5/agentpipe_darwin_amd64.tar.gz"
      sha256 "818564c790745abb0c80718bc7cb9af4da49a2a0a96dac059fa6b184ef25f1e3"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.5/agentpipe_linux_arm64.tar.gz"
      sha256 "52e2cabeec1c47f4e35e32cbc46ff5d8e274802b19bf55811543ce206b271cbd"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.5/agentpipe_linux_amd64.tar.gz"
      sha256 "c47dee23b0dc3cacf5d047e0213208c8bc5e61318a7f4297f420b3ee0bb06a16"
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
