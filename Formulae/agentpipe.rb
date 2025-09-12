class Agentpipe < Formula
  desc "Orchestrate conversations between multiple AI CLI agents"
  homepage "https://github.com/kevinelliott/agentpipe"
  version "0.0.1"
  license "MIT"

  # Formula supports building from source or downloading pre-built binaries
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.1/agentpipe_darwin_arm64.tar.gz"
      sha256 "" # Update with actual SHA256 after release
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.1/agentpipe_darwin_amd64.tar.gz"
      sha256 "" # Update with actual SHA256 after release
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.1/agentpipe_linux_arm64.tar.gz"
      sha256 "" # Update with actual SHA256 after release
    else
      url "https://github.com/kevinelliott/agentpipe/releases/download/v0.0.1/agentpipe_linux_amd64.tar.gz"
      sha256 "" # Update with actual SHA256 after release
    end
  end

  # Allow building from HEAD
  head "https://github.com/kevinelliott/agentpipe.git", branch: "main"

  # Dependencies
  depends_on "go" => :build if build.head?

  def install
    if build.head?
      # Build from source
      system "go", "build", *std_go_args(ldflags: "-s -w -X main.Version=#{version}")
    else
      # Install pre-built binary
      bin.install "agentpipe"
    end

    # Install bash completion
    generate_completions_from_executable(bin/"agentpipe", "completion", "bash")
    # Install zsh completion
    generate_completions_from_executable(bin/"agentpipe", "completion", "zsh")
    # Install fish completion
    generate_completions_from_executable(bin/"agentpipe", "completion", "fish")
  end

  def caveats
    <<~EOS
      AgentPipe has been installed!
      
      To get started:
        1. Check available AI agents: agentpipe doctor
        2. Run example: agentpipe run -a claude:Alice -a gemini:Bob -p "Hello!"
        3. View help: agentpipe --help
      
      Configuration files can be found in:
        #{etc}/agentpipe/
      
      Chat logs are saved to:
        ~/.agentpipe/chats/
    EOS
  end

  test do
    # Test doctor command
    output = shell_output("#{bin}/agentpipe doctor 2>&1")
    assert_match "AgentPipe Doctor", output
    
    # Test version output
    assert_match version.to_s, shell_output("#{bin}/agentpipe --version 2>&1")
    
    # Test help
    help_output = shell_output("#{bin}/agentpipe --help 2>&1")
    assert_match "orchestrates conversations", help_output
  end
end
