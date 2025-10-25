class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.4.3"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.3/agentpipe_darwin_arm64.tar.gz"
      sha256 "1ba6eed969e0b4779b2f52084d508f62fb37530b152ed67180672703220466e1"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.3/agentpipe_darwin_amd64.tar.gz"
      sha256 "a2ea1deac08c6d19c3ed66af3d2b604a21624bc7b985bdf07eb127c3a925e809"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.3/agentpipe_linux_arm64.tar.gz"
      sha256 "a7ed7da7b9265df934831fa48e5cc135cb2de9906c3379d762c81fc8c7c8c006"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.3/agentpipe_linux_amd64.tar.gz"
      sha256 "69d986e31051a3a64e3af3b85b31d1cc382eb3edfdd285962c4a7da84ed8249e"
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
