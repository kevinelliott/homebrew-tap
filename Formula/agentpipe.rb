class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.4.4"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.4/agentpipe_darwin_arm64.tar.gz"
      sha256 "d78c21413a9f08c749b35f99fee9cca7e8c25c7e453dd53bba9b3fbde46895bd"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.4/agentpipe_darwin_amd64.tar.gz"
      sha256 "d5b10143e3f1ff1a67c60bec4fbc8fd94cf26d1543d2b9a547fb1f4ff055e9bf"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.4/agentpipe_linux_arm64.tar.gz"
      sha256 "7cb006c4e561bc3a419e30fcc628aeaf230e76366eaa20234f7f0a4873936f80"
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.4.4/agentpipe_linux_amd64.tar.gz"
      sha256 "f2324ec0d1f6f8300b6553b99305c6e400df2956f05b48b369bdc4d21278ccb3"
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
