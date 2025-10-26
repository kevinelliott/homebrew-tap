class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.5.3"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.3/agentpipe_darwin_arm64.tar.gz"
      sha256 "8dff1c7688c51a6ec071944970b11c56de05734866157d73898b21429aa7265c"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.3/agentpipe_darwin_amd64.tar.gz"
      sha256 "6ad590e4eaadae4e9c6adefe672694871538824222501c9a62746630d62e1c4d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.3/agentpipe_linux_arm64.tar.gz"
      sha256 "9a558f4156acd39c2f87c5b66f9f4841cd580af4d8106db00924cdfce45fac03"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.3/agentpipe_linux_amd64.tar.gz"
      sha256 "35a860d720c1cef7a631b18fb4c8805269af5067372513fe1772b1b310991fcb"
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
