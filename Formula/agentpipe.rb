class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.0.10"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.10/agentpipe_darwin_arm64.tar.gz"
      sha256 "92750eeccd2546f24f9a93d7ff18ab915bea6e1f52b8f5222fba81dd2e6a3b4c"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.10/agentpipe_darwin_amd64.tar.gz"
      sha256 "ae1addf4a156485479984763f70b12b61954730eca84155619ca82eac014cf5e"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.10/agentpipe_linux_arm64.tar.gz"
      sha256 "8ceec72819c6d4e67eeb39a3a0e8f7b9e89a52270b54eb7301c46dc7ce0faf4f"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.10/agentpipe_linux_amd64.tar.gz"
      sha256 "d9542f2a01bd30a78d6899a562a080c393a13392451e12ab031e824197545ed7"
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
