class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.5.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.1/agentpipe_darwin_arm64.tar.gz"
      sha256 "d9e10fe4dc885a530e24698ec220ae14b2673dd0a26d07ba0b9f9f3eba7fb82b"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.1/agentpipe_darwin_amd64.tar.gz"
      sha256 "cafaadb4ad962e383fa8d90f7e9f462090a39bf80c193919bcdfe3f8ccfa2cbb"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.1/agentpipe_linux_arm64.tar.gz"
      sha256 "c0bba42fbb20dca0b497171f54d1f76727b710e5c0263ed85912217145968873"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.1/agentpipe_linux_amd64.tar.gz"
      sha256 "c47b14feed8f168cb1b97334a658ba85a43b56563db5a360931656a8ef66b9f8"
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
