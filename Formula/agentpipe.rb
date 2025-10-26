class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.5.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.1/agentpipe_darwin_arm64.tar.gz"
      sha256 "24ed41cc16ea104516214ecb08afbdf31673f7a940705da6e22f26cfa7bb1481"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.1/agentpipe_darwin_amd64.tar.gz"
      sha256 "fbe15efb0bcb6b1f7a5b583ce632fa119c4a0b51db37830a4e7b727e947be5ec"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.1/agentpipe_linux_arm64.tar.gz"
      sha256 "c71e606bb2dc15e8391afaacea233480ce53e591a66cf9cc08d211e513af4568"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.1/agentpipe_linux_amd64.tar.gz"
      sha256 "8eaea0c44547864fdc8cc79660c1cbe25198d75f98477c48b4d9c817fbd70414"
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
