class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.0.13"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.13/agentpipe_darwin_arm64.tar.gz"
      sha256 "712105cdee9e1f1ba9f9e4b9b378fa91611ed97d71698b6704b9ef74d8fba035"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.13/agentpipe_darwin_amd64.tar.gz"
      sha256 "3b95decfbc995de88d42404ecbfadc51381af471915e773d23d2b7f454195de6"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.13/agentpipe_linux_arm64.tar.gz"
      sha256 "a7070b523be007c423883e77cb07a6cf509845b6a592929318606cf62bfaa44c"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.13/agentpipe_linux_amd64.tar.gz"
      sha256 "1ed2efeba69a1cabf91b46c4713d8b3c98fa6fb47d26d9faabe0cb6def297a20"
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
