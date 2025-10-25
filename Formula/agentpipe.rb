class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.4.7"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.7/agentpipe_darwin_arm64.tar.gz"
      sha256 "f0989f760beda8bd1413ddacd78619f646ed6c96455e5ea2ee1c56bf3efa9f0c"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.7/agentpipe_darwin_amd64.tar.gz"
      sha256 "aa7c26c3e6de1a5f06be5495948298a82875644a673c0fd6203225002aab4bd4"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.7/agentpipe_linux_arm64.tar.gz"
      sha256 "30dbff69a6cdaea3eb086ea72a0a8f1aa4daf4f2aa63f3a47ebbfad412a5f1b7"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.7/agentpipe_linux_amd64.tar.gz"
      sha256 "d16eeb46e075079836bdda7d1191097c686d2902433b8f2bed372e17db62e360"
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
