class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.5.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.0/agentpipe_darwin_arm64.tar.gz"
      sha256 "c7390d26eff0df4bb64945b105ccae4a11dbf6cdee9b6890b06d3f9c5e0f4ee5"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.0/agentpipe_darwin_amd64.tar.gz"
      sha256 "d97ae39f8b511e4765d2219c186aa328de118edd361da7066d9d5257172be9e9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.0/agentpipe_linux_arm64.tar.gz"
      sha256 "cf61d7ac4df351cd9a411bd37740c3b356ba5d3522f70bc85cd50576d6a08d58"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.5.0/agentpipe_linux_amd64.tar.gz"
      sha256 "7f6b098b26a304505cdb5eea95346aa050baa13ca329e8b4ca2629f84fa85986"
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
