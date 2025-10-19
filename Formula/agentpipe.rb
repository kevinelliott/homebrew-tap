class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.1.4"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.4/agentpipe_darwin_arm64.tar.gz"
      sha256 "d2591f9701898d8717240d8fee5e57e33a9ba69b0ded7ce18924f38bb4a7c49d"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.4/agentpipe_darwin_amd64.tar.gz"
      sha256 "a07d2e015c122506b90fec314ea273fab53a3c406552000c138af93f4c58e689"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.4/agentpipe_linux_arm64.tar.gz"
      sha256 "43a3ef701cb7a8772842674663ccbf0d9767db8380bd9e0f5ff8a121b39065ab"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.1.4/agentpipe_linux_amd64.tar.gz"
      sha256 "f162b502d033b9d103edcce0043c52ea0e3d115ef6b652e598f08c605bd0de41"
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
