class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.1.5"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.5/agentpipe_darwin_arm64.tar.gz"
      sha256 "e63a85da1f893157fadbd89ae8620ed2f4848f86f9b4830f2b871ba012c71c5e"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.5/agentpipe_darwin_amd64.tar.gz"
      sha256 "30f7ac18fd2569d0ce40f0ba3852452fdb68cd9defe55a824f990682a009657f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.5/agentpipe_linux_arm64.tar.gz"
      sha256 "4d2677f0a2baaeb7464d5371b2d2a8cff84b3857ee81419a3b15bb208f19ec48"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.5/agentpipe_linux_amd64.tar.gz"
      sha256 "7bcad9136535a1b94a67ec2308bd843b563702cb9dc1ba10d19736e4afd6aa8e"
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
