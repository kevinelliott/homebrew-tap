class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.1.3"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.3/agentpipe_darwin_arm64.tar.gz"
      sha256 "57dd0fdd46bbb273ec2d2454cf2386a26048bd84a47b87fc58c1d95b228aaee9"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.3/agentpipe_darwin_amd64.tar.gz"
      sha256 "aa9e62b6820c85716230889ac8dca89d17b961aa8f498c6cd40fb7d4c1ceffb4"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.3/agentpipe_linux_arm64.tar.gz"
      sha256 "4c7fabfa84cfd55a1e02d767cc8efb8bcf419ab27a5ced5559315f44de3f930a"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.3/agentpipe_linux_amd64.tar.gz"
      sha256 "c6e1577aa2decccf49f7027dc344d7e48a3fbbbc83ab7fa69ea6146a546b731b"
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
