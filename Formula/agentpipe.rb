class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.4.2"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.2/agentpipe_darwin_arm64.tar.gz"
      sha256 "8ca61c028c5757e8b21736f041c97cf3f37746343758898e8eeae0ea5680831a"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.2/agentpipe_darwin_amd64.tar.gz"
      sha256 "422597940900afba4171f2e9826d3eb0cc16eb0b8673fc8a6eb16a2c1d2cbb51"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.2/agentpipe_linux_arm64.tar.gz"
      sha256 "5cabb822814b8ff56410832421b076955029cd552b2b1bb09ebb263055eb85d8"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.2/agentpipe_linux_amd64.tar.gz"
      sha256 "c6d0fa9e07cc5bca5d09327dcac56bf0380194de7ea39dfd330aef804a637623"
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
