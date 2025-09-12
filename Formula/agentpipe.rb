class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.0.7"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.7/agentpipe_darwin_arm64.tar.gz"
      sha256 "7162427da4e8453130fdcef78995cb1c3143f1ca398deb131e9bcc40cf5a57ae"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.7/agentpipe_darwin_amd64.tar.gz"
      sha256 "e8982cb9833722f1d143b61a8a16236b5289decab04c278597dc13e4eaf5693f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.7/agentpipe_linux_arm64.tar.gz"
      sha256 "baf99093203aa373740c672937591f9ac4c7d5888f18331b4bc27898e2439aed"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.7/agentpipe_linux_amd64.tar.gz"
      sha256 "8c7e665513a5a5162d686eb600010b8cba35b120e663a8da9a8f6cf24a865235"
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
