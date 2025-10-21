class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.3.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.0/agentpipe_darwin_arm64.tar.gz"
      sha256 "68dddaa665b7345fd211a4614f78159c36cfb69541764e8c686c462952aeda7c"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.0/agentpipe_darwin_amd64.tar.gz"
      sha256 "39d752a6c882faba5835d590651378a5f4be24b3fcf3e329a38e3ac197682345"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.0/agentpipe_linux_arm64.tar.gz"
      sha256 "20fe5b7e17a70a5c587e453ed946f4f076222ef9dbaa897d7652b1e42d905b6b"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.3.0/agentpipe_linux_amd64.tar.gz"
      sha256 "dce2958c012cc1fbbac11851dc5507d1b6db3a457ae7356c4e9cdfabac93c371"
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
