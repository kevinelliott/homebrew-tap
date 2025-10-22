class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.3.3"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.3/agentpipe_darwin_arm64.tar.gz"
      sha256 "630dabe39b2fa9e27a7f003628de255af9bf7ecf92d3d74a5395778121d86209"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.3/agentpipe_darwin_amd64.tar.gz"
      sha256 "897ff5e31f10370f99d85220ef3f780e96d26eb021061acc09d981a5bbdde616"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.3/agentpipe_linux_arm64.tar.gz"
      sha256 "fb04ff653bebffd33cda944da4541d0980e3c39f770dd02c825a10285a7826c3"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.3/agentpipe_linux_amd64.tar.gz"
      sha256 "2997b36697262ef502dbe6da5e1657e962e2b71b4cc567ab3a5a8e7297d1f222"
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
