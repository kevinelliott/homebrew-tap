class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.2.2"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.2/agentpipe_darwin_arm64.tar.gz"
      sha256 "e7186562d6f2f69d58ab9ae5bae6c13a9751eb658deb869868500e73b23d39e5"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.2/agentpipe_darwin_amd64.tar.gz"
      sha256 "ae1efbb2a6da39af484c87f461e34b729d4b2e3b5ea5451e7996651e2708e1aa"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.2/agentpipe_linux_arm64.tar.gz"
      sha256 "4fb4349c02dfc1b9a2338f4d35f959e55c42e81ca672dc5d4930e28f6bb0b615"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.2.2/agentpipe_linux_amd64.tar.gz"
      sha256 "0967d6097676cf4cea2540ae98f1521b03e9c212730b76476a9a12f84f98027d"
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
