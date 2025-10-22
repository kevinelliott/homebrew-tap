class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.3.2"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.2/agentpipe_darwin_arm64.tar.gz"
      sha256 "dbe95459fd5a72ae2bbe496920990007212c85db38888cadd37ffc9cb3558341"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.2/agentpipe_darwin_amd64.tar.gz"
      sha256 "e6d03d9bc1e1f4bcbf99119e5682387dd423c6a75b79941f54b105f673e12854"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.2/agentpipe_linux_arm64.tar.gz"
      sha256 "690fdaebaafb9b1bfa29cbc0a99542add7e935209945e02a1707ba5a3d065fe2"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.2/agentpipe_linux_amd64.tar.gz"
      sha256 "b7d011283156e11aba8a23574dbf484aa331e5651be99fb9e773ca828163d4e4"
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
