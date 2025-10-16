class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.1.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.0/agentpipe_darwin_arm64.tar.gz"
      sha256 "bf1a9d861e1e2a9febd632c187aa4bc2a76850c9b74a04d6d22c9a894437c376"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.0/agentpipe_darwin_amd64.tar.gz"
      sha256 "6a069f10797f7ee93fd534977620130677597851094031aff4cfdee970e0363b"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.0/agentpipe_linux_arm64.tar.gz"
      sha256 "965d675d2f3c55b8ac819b58c1b8c379cb212628a93eeafc61e806c865307032"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.0/agentpipe_linux_amd64.tar.gz"
      sha256 "125bd8302981ac4bef055c6210cdf8fec3382f4f6f12cd3df5f09c9c272ca0b3"
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
